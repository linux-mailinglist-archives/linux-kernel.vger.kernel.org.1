Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1592D7E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393948AbgLKSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390795AbgLKSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:31:17 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056EC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:30:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b64so5351942qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xK6pOr6PCBHPT0IldAlBcc/VgyJoh7ibqnbLWD1qV3c=;
        b=XKVeo8AyGSGh6Tbw/nHpTd8Hx6Zs7OPjslEkaXv3CcGbnX8DgviAb54PZlqpX4xZBr
         f3KNCF/2y3uXKuWlyOHz0+R6W3m7KbKK3246egL5T8e8EmwK4j3pNYMupRe7pDziKl7x
         /GqkKMmr1ux4kFuMLxTtBzKEcFxAo1pondeS3LFwGTFzCJbndsLbOfVMbEDluVBGd6HP
         YctcJAG57Luzo5vyg8MXyvcDV0d0iUYgo/iOkYpd7PypvxYfitIrfS/zR8OOboMzTVjL
         iLvRo8zBbsbKFC0TXUEPAkZTh813tXcWIX/PxXIqcm6X7NoNEEMHxC/uINeoHrLJWOHc
         /B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xK6pOr6PCBHPT0IldAlBcc/VgyJoh7ibqnbLWD1qV3c=;
        b=bLh7ROQeeMBfrOxnA+e8VOKGqneFtlOVurOkMkYnOghG+q6UEcIv/n8FLF/Wce3xzN
         EowLeWShBMy/vwzlsDoH90xdteA9D4+LSFg0BYMFsnlySfQf1/ozV/yQNnzjmbajrOmN
         wEk4lTmbT9S9EbivEPZuCIemsl9PrlT3Q0V+yNgYAPwVzW1kYK5o8TYn2ri9SuzLd4mU
         tbGBseGMmLaqFtlyRCXprbDtCIcgihzcXgYg02to93dYik6lm2XALVDVIVUF9aQpM9J7
         5M+YpczSttNdU6CVRpmcqKGNsLHYhHHM217jlDkiSLsPzEJ4ZxpB478Tapd/C5dilbpc
         ymmA==
X-Gm-Message-State: AOAM531MJNzzhx9RGTELOXPl0s3Hj3lM+1gvF6NLMLkXV0jpjsoz8Eav
        h2sIj7PanSVotUo1/GQumKYtnH2FiXSKHF1cwmRLEg==
X-Google-Smtp-Source: ABdhPJz+nCt5NuwdZbJMUctDs5yg5lEDGEziwYC1c4gIvxpitHyQfvw+1B/C4Mm+p0uklfOgNdoEmH3hEJ3stN3rcpo=
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr17301713qkw.147.1607711436505;
 Fri, 11 Dec 2020 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20201210044400.1080308-1-hridya@google.com> <b5adfe46-8615-5821-d092-2b93feed5b79@amd.com>
 <X9H0JREcdxDsMtLX@kroah.com> <20201210102727.GE401619@phenom.ffwll.local>
 <X9H+3AP1q39aMxeb@kroah.com> <f95ee5dc-62f8-4870-11e4-3513dc8382ef@amd.com>
 <CA+wgaPPtoz_JSAwsVVpFGLrcrO8-tAGD+gdrsWmBA3jpidigzQ@mail.gmail.com> <e854d168-9299-7326-743e-874882d8073f@amd.com>
In-Reply-To: <e854d168-9299-7326-743e-874882d8073f@amd.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 11 Dec 2020 10:30:00 -0800
Message-ID: <CA+wgaPM2v=+j3bpTdDGkfm+qrizW=q1qnTP9yAVGRu7_4Lf6-w@mail.gmail.com>
Subject: Re: [PATCH] dmabuf: Add the capability to expose DMA-BUF stats in sysfs
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Android Kernel Team <kernel-team@android.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Christian!

On Fri, Dec 11, 2020 at 12:03 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.12.20 um 23:41 schrieb Hridya Valsaraju:
> > Thanks again for the reviews!
> >
> > On Thu, Dec 10, 2020 at 3:03 AM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 10.12.20 um 11:56 schrieb Greg KH:
> >>> On Thu, Dec 10, 2020 at 11:27:27AM +0100, Daniel Vetter wrote:
> >>>> On Thu, Dec 10, 2020 at 11:10:45AM +0100, Greg KH wrote:
> >>>>> On Thu, Dec 10, 2020 at 10:58:50AM +0100, Christian K=C3=B6nig wrot=
e:
> >>>>>> In general a good idea, but I have a few concern/comments here.
> >>>>>>
> >>>>>> Am 10.12.20 um 05:43 schrieb Hridya Valsaraju:
> >>>>>>> This patch allows statistics to be enabled for each DMA-BUF in
> >>>>>>> sysfs by enabling the config CONFIG_DMABUF_SYSFS_STATS.
> >>>>>>>
> >>>>>>> The following stats will be exposed by the interface:
> >>>>>>>
> >>>>>>> /sys/kernel/dmabuf/<inode_number>/exporter_name
> >>>>>>> /sys/kernel/dmabuf/<inode_number>/size
> >>>>>>> /sys/kernel/dmabuf/<inode_number>/dev_map_info
> >>>>>>>
> >>>>>>> The inode_number is unique for each DMA-BUF and was added earlier=
 [1]
> >>>>>>> in order to allow userspace to track DMA-BUF usage across differe=
nt
> >>>>>>> processes.
> >>>>>>>
> >>>>>>> Currently, this information is exposed in
> >>>>>>> /sys/kernel/debug/dma_buf/bufinfo.
> >>>>>>> However, since debugfs is considered unsafe to be mounted in prod=
uction,
> >>>>>>> it is being duplicated in sysfs.
> >>>>>> Mhm, this makes it part of the UAPI. What is the justification for=
 this?
> >>>>>>
> >>>>>> In other words do we really need those debug information in a prod=
uction
> >>>>>> environment?
> >>>>> Production environments seem to want to know who is using up memory=
 :)
> >>>> This only shows shared memory, so it does smell a lot like $specific=
_issue
> >>>> and we're designing a narrow solution for that and then have to carr=
y it
> >>>> forever.
> >>> I think the "issue" is that this was a feature from ion that people
> >>> "missed" in the dmabuf move.  Taking away the ability to see what kin=
d
> >>> of allocations were being made didn't make a lot of debugging tools
> >>> happy :(
> >> Yeah, that is certainly a very valid concern.
> >>
> >>> But Hridya knows more, she's been dealing with the transition for a l=
ong
> >>> time now.
> > Currently, telemetry tools capture this information(along with other
> > memory metrics) periodically as well as on important events like a
> > foreground app kill (which might have been triggered by an LMK). We
> > would also like to get a snapshot of the system memory usage on other
> > events such as OOM kills and ANRs.
>
> That userspace tools are going to use those files directly is the
> justification you need for the stable UAPI provided by sysfs.
>
> Otherwise debugfs would be the way to go even when that is often disabled=
.
>
> Please change the commit message to reflect that.


Sounds good, I will make sure to include it in the commit message of
the next version.


>
> >>>> E.g. why is the list of attachments not a sysfs link? That's how we
> >>>> usually expose struct device * pointers in sysfs to userspace, not a=
s a
> >>>> list of things.
> >>> These aren't struct devices, so I don't understand the objection here=
.
> >>> Where else could these go in sysfs?
> >> Sure they are! Just take a look at an attachment:
> >>
> >> struct dma_buf_attachment {
> >>            struct dma_buf *dmabuf;
> >>            struct device *dev;
> >>
> >> This is the struct device which is importing the buffer and the patch =
in
> >> discussion is just printing the name of this device into sysfs.
> > I actually did not know that this is not ok to do. I will change it in
> > the next version of the patch to be sysfs links instead.
>
> Thanks, you need to restructure this patch a bit. But I agree with
> Daniel that links to the devices which are attached are more appropriate.
>
> I'm just not sure how we want to represent the map count for each
> attachment then, probably best to have that as separate file as well.


Yes, I can add the map count as a separate file. Thanks again!

Regards,
Hridya


>
> Regards,
> Christian.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
