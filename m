Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927A2D5B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbgLJNLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbgLJNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:11:03 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B30C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:10:22 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o11so4781895ote.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5SZx0SF1+bmdIPGDx8XS9Yvh6cMFc1HMujYWwx4oFXo=;
        b=ljmsD/nZGyo/+nDuS0o0wS7bR94cQDN8VGl9oI3x9gF6FY1HbovjAwtbwEL91ATJtm
         1xTzwHF+H8teshZzyQ3IR9ZGQiWUlsBu2AfAUddntFcJyQQeHRNrIFzGacznjrhKTKvg
         zGEZhXmHkuly95lHRKyzmo3PZkbgX74s/29oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5SZx0SF1+bmdIPGDx8XS9Yvh6cMFc1HMujYWwx4oFXo=;
        b=eQOC9umQVNCByeclxw7UnlDmq1nCFwnKoZRKC65meOUMTBk947v+52yn6PNydn7QVj
         kzgDw9C+Db4eu1yD7IwTNucXnSloeajYq8UMhf0pyh3QMBGe7KLF9cZWMAb977j53jVW
         5pA0gd9+DK1GqLFyO0/rEU0r0dsnTOxCzm1+lDKHwgN1zfeT0qsa8cE4EbWyYLnFlM6G
         dIsbC+wibAItvKdx/VRCU9NJqQqNHrp+2WuqPssnYyooRLCeNLEZVTsLzGVYnnf9y+MH
         CrsoZsPd16ZpVkgb2SszI4P2tEBq952v+x3Q7E3s85LBP/tIdV31GqwFjI00aSHjleHO
         SvbA==
X-Gm-Message-State: AOAM530Gkpl+NXMNsNVB2sbgUu4qauZFPwS5w7gjnWFt//2LD7W4jLP0
        /ECZ6zqcrPL6+w4f5k/6UjGooJ+nwcQt54OUeIPzCIM8hbk=
X-Google-Smtp-Source: ABdhPJwe0G/fIm4wrIEbslkY/Xrvlb1182PcLJFrYAgq3Tmq7oxccHPXXb0WkMQH6isTqYmJy19qnmcJPRyIsmZ6nTE=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr5751241otb.281.1607605822145;
 Thu, 10 Dec 2020 05:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20201210044400.1080308-1-hridya@google.com> <b5adfe46-8615-5821-d092-2b93feed5b79@amd.com>
 <X9H0JREcdxDsMtLX@kroah.com> <20201210102727.GE401619@phenom.ffwll.local>
 <X9H+3AP1q39aMxeb@kroah.com> <CAKMK7uFD3fE01Li3JOpHpzP7313OT3xpcjBwzSVjrCGAmab2Zg@mail.gmail.com>
 <X9IPhEkcZO+Ut5RH@kroah.com>
In-Reply-To: <X9IPhEkcZO+Ut5RH@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 10 Dec 2020 14:10:10 +0100
Message-ID: <CAKMK7uEM636NjEcxLfsKJa9H71i0mkQ3dsT3yWwHTcVFk4r+Sg@mail.gmail.com>
Subject: Re: [PATCH] dmabuf: Add the capability to expose DMA-BUF stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 10, 2020 at 12:26:01PM +0100, Daniel Vetter wrote:
> > On Thu, Dec 10, 2020 at 11:55 AM Greg KH <gregkh@linuxfoundation.org> w=
rote:
> > >
> > > On Thu, Dec 10, 2020 at 11:27:27AM +0100, Daniel Vetter wrote:
> > > > On Thu, Dec 10, 2020 at 11:10:45AM +0100, Greg KH wrote:
> > > > > On Thu, Dec 10, 2020 at 10:58:50AM +0100, Christian K=C3=B6nig wr=
ote:
> > > > > > In general a good idea, but I have a few concern/comments here.
> > > > > >
> > > > > > Am 10.12.20 um 05:43 schrieb Hridya Valsaraju:
> > > > > > > This patch allows statistics to be enabled for each DMA-BUF i=
n
> > > > > > > sysfs by enabling the config CONFIG_DMABUF_SYSFS_STATS.
> > > > > > >
> > > > > > > The following stats will be exposed by the interface:
> > > > > > >
> > > > > > > /sys/kernel/dmabuf/<inode_number>/exporter_name
> > > > > > > /sys/kernel/dmabuf/<inode_number>/size
> > > > > > > /sys/kernel/dmabuf/<inode_number>/dev_map_info
> > > > > > >
> > > > > > > The inode_number is unique for each DMA-BUF and was added ear=
lier [1]
> > > > > > > in order to allow userspace to track DMA-BUF usage across dif=
ferent
> > > > > > > processes.
> > > > > > >
> > > > > > > Currently, this information is exposed in
> > > > > > > /sys/kernel/debug/dma_buf/bufinfo.
> > > > > > > However, since debugfs is considered unsafe to be mounted in =
production,
> > > > > > > it is being duplicated in sysfs.
> > > > > >
> > > > > > Mhm, this makes it part of the UAPI. What is the justification =
for this?
> > > > > >
> > > > > > In other words do we really need those debug information in a p=
roduction
> > > > > > environment?
> > > > >
> > > > > Production environments seem to want to know who is using up memo=
ry :)
> > > >
> > > > This only shows shared memory, so it does smell a lot like $specifi=
c_issue
> > > > and we're designing a narrow solution for that and then have to car=
ry it
> > > > forever.
> > >
> > > I think the "issue" is that this was a feature from ion that people
> > > "missed" in the dmabuf move.  Taking away the ability to see what kin=
d
> > > of allocations were being made didn't make a lot of debugging tools
> > > happy :(
> >
> > If this is just for dma-heaps then why don't we add the stuff back
> > over there? It reinforces more that the android gpu stack and the
> > non-android gpu stack on linux are fairly different in fundamental
> > ways, but that's not really new.
>
> Back "over where"?
>
> dma-bufs are not only used for the graphics stack on android from what I
> can tell, so this shouldn't be a gpu-specific issue.

dma-buf heaps exist because android, mostly because google mandates
it. There's not a whole lot (meaning zero) of actually open gpu stacks
around that run on android and use dma-buf heaps like approved google
systems, largely because the gralloc implementation in mesa just
doesnt.

So if android needs some quick debug output in sysfs, we can just add
that in dma-buf heaps, for android only, problem solved. And much less
annoying review to make sure it actually fits into the wider ecosystem
because as-is (and I'm not seeing that chance anytime soon), dma-buf
heaps is for android only. dma-buf at large isn't, so merging a debug
output sysfs api that's just for android but misses a ton of the more
generic features and semantics of dma-buf is not great.
-Daniel

-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
