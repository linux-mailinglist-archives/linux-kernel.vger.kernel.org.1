Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0C3045F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbhAZSFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:05:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:14231 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390749AbhAZJYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:24:41 -0500
IronPort-SDR: /LXV0vArh8/ZHVr7GcEAM2WXDQ/4hSQuKJCHU7j4aDf4C9V+U6OoDILUCaG9t8k/TnYnbiwZ2s
 jrAudxbrg/wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198659225"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="198659225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 01:22:55 -0800
IronPort-SDR: 8bg0+udZ4EHNtIM41m9viOEmFKGepqJ0K6K/49Siun3VWZ2iQPuTanu4iHm7utXnPFfYjuVcOG
 nq1cCTvGuKAA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387760829"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.52.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 01:22:52 -0800
Date:   Tue, 26 Jan 2021 10:22:49 +0100 (CET)
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Anton Yakovlev <anton.yakovlev@opensynergy.com>
cc:     virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 8/9] ALSA: virtio: introduce PCM channel map support
In-Reply-To: <20210124165408.1122868-9-anton.yakovlev@opensynergy.com>
Message-ID: <643248d4-d246-686f-34c3-7e592777e3ec@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-9-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> Enumerate all available PCM channel maps and create ALSA controls.
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> sound/virtio/Makefile       |   1 +
> sound/virtio/virtio_card.c  |  15 +++
> sound/virtio/virtio_card.h  |   8 ++
> sound/virtio/virtio_chmap.c | 237 ++++++++++++++++++++++++++++++++++++
> sound/virtio/virtio_pcm.h   |   4 +
> 5 files changed, 265 insertions(+)
> create mode 100644 sound/virtio/virtio_chmap.c

[snip]

> diff --git a/sound/virtio/virtio_chmap.c b/sound/virtio/virtio_chmap.c
> new file mode 100644
> index 000000000000..8a2ddc4dcffb
> --- /dev/null
> +++ b/sound/virtio/virtio_chmap.c
> @@ -0,0 +1,237 @@

[snip]

> +/**
> + * virtsnd_chmap_parse_cfg() - Parse the channel map configuration.
> + * @snd: VirtIO sound device.
> + *
> + * This function is called during initial device initialization.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_chmap_parse_cfg(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	unsigned int i;
> +	int rc;
> +
> +	virtio_cread(vdev, struct virtio_snd_config, chmaps, &snd->nchmaps);
> +	if (!snd->nchmaps)
> +		return 0;
> +
> +	snd->chmaps = devm_kcalloc(&vdev->dev, snd->nchmaps,
> +				   sizeof(*snd->chmaps), GFP_KERNEL);
> +	if (!snd->chmaps)
> +		return -ENOMEM;
> +
> +	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CHMAP_INFO, 0,
> +				    snd->nchmaps, sizeof(*snd->chmaps),
> +				    snd->chmaps);
> +	if (rc)
> +		return rc;
> +
> +	/* Count the number of channel maps per each PCM device/stream. */
> +	for (i = 0; i < snd->nchmaps; ++i) {
> +		struct virtio_snd_chmap_info *info = &snd->chmaps[i];
> +		unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
> +		struct virtio_pcm *pcm;
> +		struct virtio_pcm_stream *stream;
> +
> +		pcm = virtsnd_pcm_find_or_create(snd, nid);
> +		if (IS_ERR(pcm))
> +			return PTR_ERR(pcm);
> +
> +		switch (info->direction) {
> +		case VIRTIO_SND_D_OUTPUT: {
> +			stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
> +			break;
> +		}
> +		case VIRTIO_SND_D_INPUT: {
> +			stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
> +			break;
> +		}
> +		default: {
> +			dev_err(&vdev->dev,
> +				"chmap #%u: unknown direction (%u)\n", i,
> +				info->direction);
> +			return -EINVAL;
> +		}
> +		}
> +
> +		stream->nchmaps++;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_chmap_add_ctls() - Create an ALSA control for channel maps.
> + * @pcm: ALSA PCM device.
> + * @direction: PCM stream direction (SNDRV_PCM_STREAM_XXX).
> + * @stream: VirtIO PCM stream.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_chmap_add_ctls(struct snd_pcm *pcm, int direction,
> +				  struct virtio_pcm_stream *stream)
> +{
> +	unsigned int i;
> +	int max_channels = 0;
> +
> +	for (i = 0; i < stream->nchmaps; i++)
> +		if (max_channels < stream->chmaps[i].channels)
> +			max_channels = stream->chmaps[i].channels;
> +
> +	return snd_pcm_add_chmap_ctls(pcm, direction, stream->chmaps,
> +				      max_channels, 0, NULL);
> +}
> +
> +/**
> + * virtsnd_chmap_build_devs() - Build ALSA controls for channel maps.
> + * @snd: VirtIO sound device.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_chmap_build_devs(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_pcm *pcm;
> +	struct virtio_pcm_stream *stream;
> +	unsigned int i;
> +	int rc;
> +
> +	/* Allocate channel map elements per each PCM device/stream. */
> +	list_for_each_entry(pcm, &snd->pcm_list, list) {
> +		for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
> +			stream = &pcm->streams[i];
> +
> +			if (!stream->nchmaps)
> +				continue;
> +
> +			stream->chmaps = devm_kcalloc(&vdev->dev,
> +						      stream->nchmaps + 1,
> +						      sizeof(*stream->chmaps),
> +						      GFP_KERNEL);
> +			if (!stream->chmaps)
> +				return -ENOMEM;
> +
> +			stream->nchmaps = 0;
> +		}
> +	}
> +
> +	/* Initialize channel maps per each PCM device/stream. */
> +	for (i = 0; i < snd->nchmaps; ++i) {
> +		struct virtio_snd_chmap_info *info = &snd->chmaps[i];
> +		unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
> +		unsigned int channels = info->channels;
> +		unsigned int ch;
> +		struct snd_pcm_chmap_elem *chmap;
> +
> +		pcm = virtsnd_pcm_find(snd, nid);
> +		if (IS_ERR(pcm))
> +			return PTR_ERR(pcm);
> +
> +		if (info->direction == VIRTIO_SND_D_OUTPUT)
> +			stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
> +		else
> +			stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
> +
> +		chmap = &stream->chmaps[stream->nchmaps++];
> +
> +		if (channels > ARRAY_SIZE(chmap->map))
> +			channels = ARRAY_SIZE(chmap->map);
> +
> +		chmap->channels = channels;
> +
> +		for (ch = 0; ch < channels; ++ch) {
> +			u8 position = info->positions[ch];
> +
> +			if (position >= ARRAY_SIZE(g_v2a_position_map))
> +				return -EINVAL;
> +
> +			chmap->map[ch] = g_v2a_position_map[position];
> +		}
> +	}

You enter this function after virtsnd_chmap_parse_cfg() has run. And 
virtsnd_chmap_parse_cfg() has already found or created all the PCMs and 
counted channel maps - the same way as you do in the above loop. Wouldn't 
it be enough to reuse the result of that counting and avoid re-counting 
here?

> +
> +	/* Create an ALSA control per each PCM device/stream. */
> +	list_for_each_entry(pcm, &snd->pcm_list, list) {
> +		if (!pcm->pcm)
> +			continue;
> +
> +		for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
> +			stream = &pcm->streams[i];
> +
> +			if (!stream->nchmaps)
> +				continue;
> +
> +			rc = virtsnd_chmap_add_ctls(pcm->pcm, i, stream);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
