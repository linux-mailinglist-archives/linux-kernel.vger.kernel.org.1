Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5630455C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbhAZRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:31:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:64921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbhAZHgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:36:44 -0500
IronPort-SDR: 8CcabyWhltogZNTQFtR2GXT3XplAHNFBryKzWYj+8BgnP9dAHs+ibWiyNBQMb/jW6bqUKtHqbP
 0PIotnA14Tqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198645450"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="198645450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 23:26:02 -0800
IronPort-SDR: Sd5dS09jU/hBm6xU+DWJk8sUX/O9t+7dGZwRVHfAOilhhBCQCOJTOb8K/pIcZfNyzFi2khNo+8
 eiASdJp37QAg==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387723377"
Received: from kleve-mobl1.ger.corp.intel.com (HELO ubuntu) ([10.252.52.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 23:26:00 -0800
Date:   Tue, 26 Jan 2021 08:25:58 +0100 (CET)
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 6/9] ALSA: virtio: PCM substream operators
In-Reply-To: <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
Message-ID: <d92151ca-cde3-d1e6-23fe-f0c671379e9@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-7-anton.yakovlev@opensynergy.com> <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing I missed yesterday:

On Mon, 25 Jan 2021, Guennadi Liakhovetski wrote:

>
> On Sun, 24 Jan 2021, Anton Yakovlev wrote:
>
>> Introduce the operators required for the operation of substreams.
>> 
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> ---
>> sound/virtio/Makefile         |   3 +-
>> sound/virtio/virtio_pcm.c     |   5 +-
>> sound/virtio/virtio_pcm.h     |   2 +
>> sound/virtio/virtio_pcm_ops.c | 513 ++++++++++++++++++++++++++++++++++
>> 4 files changed, 521 insertions(+), 2 deletions(-)
>> create mode 100644 sound/virtio/virtio_pcm_ops.c
>
> [snip]
>
>> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
>> new file mode 100644
>> index 000000000000..19882777fcd6
>> --- /dev/null
>> +++ b/sound/virtio/virtio_pcm_ops.c
>> @@ -0,0 +1,513 @@
>
> [snip]
>
>> +/**
>> + * virtsnd_pcm_release() - Release the PCM substream on the device side.
>> + * @substream: VirtIO substream.
>> + *
>> + * Context: Any context that permits to sleep.
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream 
>> *substream)
>> +{
>> +	/*
>> +	 * The spec states that upon receipt of the RELEASE command "the 
>> device
>> +	 * MUST complete all pending I/O messages for the specified stream 
>> ID".
>> +	 * Thus, we consider the absence of I/O messages in the queue as an
>> +	 * indication that the substream has been released.
>> +	 */
>> +	return atomic_read(&substream->msg_count) == 0;
>
> Also here having it atomic doesn't really seem to help. This just means, that 
> at some point of time it was == 0.
>
>> +}
>> +
>> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
>
> kernel-doc missing
>
>> +{
>> +	struct virtio_snd *snd = substream->snd;
>> +	struct virtio_snd_msg *msg;
>> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
>> +	int rc;
>> +
>> +	msg = virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
>> +					GFP_KERNEL);
>> +	if (IS_ERR(msg))
>> +		return PTR_ERR(msg);
>> +
>> +	rc = virtsnd_ctl_msg_send_sync(snd, msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return wait_event_interruptible_timeout(substream->msg_empty,
>> +						virtsnd_pcm_released(substream),
>> +						js);

wait_event_interruptible_timeout() will return a positive number in 
success cases, 0 means a timeout and condition still false. Whereas when 
you call this function you interpret 0 as success and you expect any != 0 
to be a negative error. Wondering how this worked during your tests?

Thanks
Guennadi
