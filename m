Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFD304577
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392510AbhAZRiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:38:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:59008 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbhAZHqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:46:33 -0500
IronPort-SDR: 8YPlViTyZaTc0oJHvKbDCC/wRm8QgbIM3g/dIwj2Dc1DLqWhJcy+H9x0DNYPv+h/x1tO38ZUeR
 OVbPVaJouk6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159039066"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159039066"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 23:40:53 -0800
IronPort-SDR: zgP8Qm+Gvv16cNo08q7txgjrXUAHycE6DfPglon2E99+Tj1Ov+xN+jww9nqH65/mWfOgqC6HX3
 XZcYxqUhNXKg==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387728025"
Received: from kleve-mobl1.ger.corp.intel.com (HELO ubuntu) ([10.252.52.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 23:40:43 -0800
Date:   Tue, 26 Jan 2021 08:40:41 +0100 (CET)
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Anton Yakovlev <anton.yakovlev@opensynergy.com>
cc:     virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 7/9] ALSA: virtio: introduce jack support
In-Reply-To: <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
Message-ID: <8dce1870-9ffe-949d-ee5a-f2564f88ac5@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> Enumerate all available jacks and create ALSA controls.
>
> At the moment jacks have a simple implementation and can only be used
> to receive notifications about a plugged in/out device.
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> sound/virtio/Makefile      |   1 +
> sound/virtio/virtio_card.c |  18 +++
> sound/virtio/virtio_card.h |  12 ++
> sound/virtio/virtio_jack.c | 255 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 286 insertions(+)
> create mode 100644 sound/virtio/virtio_jack.c

[snip]

> diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
> new file mode 100644
> index 000000000000..83593c59f6bf
> --- /dev/null
> +++ b/sound/virtio/virtio_jack.c
> @@ -0,0 +1,255 @@

[snip]

> +/**
> + * virtsnd_jack_parse_cfg() - Parse the jack configuration.
> + * @snd: VirtIO sound device.
> + *
> + * This function is called during initial device initialization.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_jack_parse_cfg(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_snd_jack_info *info;
> +	unsigned int i;
> +	int rc;
> +
> +	virtio_cread(vdev, struct virtio_snd_config, jacks, &snd->njacks);
> +	if (!snd->njacks)
> +		return 0;
> +
> +	snd->jacks = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks),
> +				  GFP_KERNEL);
> +	if (!snd->jacks)
> +		return -ENOMEM;
> +
> +	info = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*info), GFP_KERNEL);

just kcalloc()

> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njacks,
> +				    sizeof(*info), info);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < snd->njacks; ++i) {
> +		struct virtio_jack *jack = &snd->jacks[i];
> +		struct virtio_pcm *pcm;
> +
> +		jack->nid = le32_to_cpu(info[i].hdr.hda_fn_nid);
> +		jack->features = le32_to_cpu(info[i].features);
> +		jack->defconf = le32_to_cpu(info[i].hda_reg_defconf);
> +		jack->caps = le32_to_cpu(info[i].hda_reg_caps);
> +		jack->connected = info[i].connected;
> +
> +		pcm = virtsnd_pcm_find_or_create(snd, jack->nid);
> +		if (IS_ERR(pcm))
> +			return PTR_ERR(pcm);
> +	}
> +
> +	devm_kfree(&vdev->dev, info);
> +
> +	return 0;
> +}

Thanks
Guennadi
