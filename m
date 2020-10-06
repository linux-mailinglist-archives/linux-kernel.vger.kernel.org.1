Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D68284EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:15:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:15:13 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxEYY-1kakqt0YUC-00xaie; Tue, 06 Oct 2020 17:15:11 +0200
Received: by mail-qk1-f170.google.com with SMTP id q5so17062541qkc.2;
        Tue, 06 Oct 2020 08:15:10 -0700 (PDT)
X-Gm-Message-State: AOAM530UbBh1EQ1VU3hy+ZkkaI437DwpTJPzjz3rG/E8wM/MWMT9CIZK
        5MQiGA2efvc31NymD/BqtLUkgXnFK5JGCNu0dOI=
X-Google-Smtp-Source: ABdhPJxTpgArrfDQo8W5CK8nNZlKm7RcxTTiNBO5j8QFBSYk1wLZmZUcMy0G3P6Si2XG12LUKy8ETjtd5I7v2oNBuC8=
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr5889944qkg.138.1601997309825;
 Tue, 06 Oct 2020 08:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200917152823.1241599-1-arnd@arndb.de> <cbbed130-3329-85a5-f360-3537391c1569@xs4all.nl>
In-Reply-To: <cbbed130-3329-85a5-f360-3537391c1569@xs4all.nl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Oct 2020 17:14:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3KCxSJyfoBe40_=Qjsmc_e-yJFVE9jzaTGBz7t76GBHQ@mail.gmail.com>
Message-ID: <CAK8P3a3KCxSJyfoBe40_=Qjsmc_e-yJFVE9jzaTGBz7t76GBHQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] media: v4l2: simplify compat ioctl handling
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FW9gGMIsqjHVgMZb8vYH5MGqjymQyRPnT2DGNU+cRK2Ad76ltxe
 R2CeApZNQVYruN7A7st6Ziuw+cPbzDTiTbfQ5U2CuGNNo4r+jmJPWB69YJfMHblTfewKK6C
 sMOhiyqMlXNCD6JsogUfsQQFGBZhUevD8IjhfzupCX5XJKSGqzc6PqH7mKrWvuKG1Yj7ShK
 XQvxaXszuTHXkZ48YoooA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hWbg3vtgPs0=:LozlN2NBvlvqnEq8eMGmjD
 yjpxqT9IKMszl6uXb4yUBx9rx59lu2YO+kLDtLDMFT8nyCf8MvfFbiWFp5lhV+pYUAEJJlZPs
 ckuN8ltaUT2wj1XKf4oHRxSmTFTPSnaJSXzn0FGyollZvKVvQYaNdIPP0bA2ZcM3NeJ/kSQYj
 zL0U32RG2kFvqLtYWSKCdEp/n1KdSwGW8BETT4Ug2vaon7sbVnyPXIumB4Wr8GrDFT661k0e0
 YmNft0IVGF3YgtFI3ttnv5zUApxJ6Is71kZEMo9dLOiWy7ONZU1pVq+KPL/gyFkajeiX+3Wcu
 GVX88NlelM5uq/Ax5kAw4Xuah1XdC+ldgr7EkUncaH47/EmYrvjVQe466vxJvIXTX0e4ui56i
 ShJ7gX28ve3Ehn/Ldo5sD5EBgaHnmcQixcWuFWoenndW2DUnzZ/jCJ1bffuD/htzHTYPo9NWR
 +0keK7CDwLm/dDzC3Hs9xGZD3tyzHD6YAMOCa5oHGUzXeBmsBei5RtP6JfRi5aUNB26Iby3zA
 Ai1ZSc2ivTvmtHVOl97ACk64T21tDz896e7nGlZ2EHa1wEGq1aA8u/oyeFpmyYdEL+sjE+n4Z
 2rK8am1fHeFTFkw5YAmKY7wgwMZUz3Uv2CB84/FVqwzd5zm1lE/3tctr8rh91CkHCZpz4xUV1
 B/x3Emk1PaCtqixzedrx6Jd+oOglTmZ1x6kgaAfpK6wKo5iqDO9DFMgY36pb9Sf1BbCoGYbbs
 ztkCM0JS1IwtWN6vKFn11S7OgwUm/cPCvSTq2HKH84bUOC2ucD3BCxZGL7pehesNUb4ySsxui
 rUDTi05RHvu/c1O+Tj482nqLV6UebuKJuvcebREWyKDbbaiHR5OjAQe2ccMy5JBKpckR4d9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 4:32 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 17/09/2020 17:28, Arnd Bergmann wrote:

> While testing I found a lot of bugs. Below is a patch that sits on top
> of your series and fixes all the bugs:
>
> - put_v4l2_standard32: typo: p64->index -> p64->id
> - get_v4l2_plane32: typo: p64 -> plane32
>                     typo: duplicate bytesused: the 2nd should be 'length'
> - put_v4l2_plane32: typo: duplicate bytesused: the 2nd should be 'length'
> - get_v4l2_buffer32/get_v4l2_buffer32_time32: missing compat_ptr for vb32.m.userptr
> - get_v4l2_buffer32/get_v4l2_buffer32_time32: drop querybuf bool
> - put_v4l2_buffer32/put_v4l2_buffer32_time32: add uintptr_t cast for vb->m.userptr
> - get_v4l2_ext_controls32: typo: error_idx -> request_fd
> - put_v4l2_ext_controls32: typo: error_idx -> request_fd
> - v4l2_compat_translate_cmd: missing case VIDIOC_CREATE_BUFS32
> - v4l2_compat_translate_cmd: #ifdef CONFIG_COMPAT_32BIT_TIME for
>   case VIDIOC_DQEVENT32_TIME32 and return VIDIOC_DQEVENT
> - v4l2_compat_put_user: #ifdef CONFIG_COMPAT_32BIT_TIME for case VIDIOC_DQEVENT32_TIME32
> - v4l2_compat_get_array_args: typo: p64 -> b64
> - v4l2_compat_put_array_args: typo: p64 -> b64
> - video_get_user: make sure INFO_FL_CLEAR_MASK is honored, also when in_compat_syscall()
> - video_usercopy: err = v4l2_compat_put_array_args overwrote the original ioctl err value.
>   Handle this correctly.
>
> I've tested this as well with the y2038 compat mode (i686 with 64-bit time_t)
> and that too works fine.

I'm not too surprised that there were bugs, but I am a little shocked
at how much
I got wrong in the end. Thanks a lot for testing my series and fixing all of the
above!

I've carefully studied your changes and folded them into my series now.
Most of the changes were obvious in hindsight, just two things to comment on:

>  #ifdef CONFIG_COMPAT_32BIT_TIME
>  static int get_v4l2_buffer32_time32(struct v4l2_buffer *vb,
> -                                   struct v4l2_buffer32_time32 __user *arg,
> -                                   bool querybuf)
> +                                   struct v4l2_buffer32_time32 __user *arg)
>  {
>         struct v4l2_buffer32_time32 vb32;
>
> @@ -489,8 +484,6 @@ static int get_v4l2_buffer32_time32(struct v4l2_buffer *vb,
>         if (V4L2_TYPE_IS_MULTIPLANAR(vb->type))
>                 vb->m.planes = (void __force *)
>                                 compat_ptr(vb32.m.planes);
> -       if (querybuf)
> -               vb->request_fd = 0;
>
>         return 0;

It took me too long to understand what you changed here, as this depends
on your rewrite of video_get_user(). The new version definitely looks
cleaner. After folding in the video_get_user() changes, I've amended
that changelog of the "media: v4l2: prepare compat-ioctl rework" commit
with:

|    [...]
|    provide a location for reading and writing user space data from inside
|    of the generic video_usercopy() helper.
|
|    Hans Verkuil rewrote the video_get_user() function here to simplify
|    the zeroing of the extra input fields and fixed a couple of bugs in
|    the original implementation.
|
|    Co-developed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
|    Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
|    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I could split that out into a separate patch if you prefer.

> @@ -1025,8 +1020,10 @@ int v4l2_compat_put_user(void __user *arg, void *parg, unsigned int cmd)
>  #ifdef CONFIG_X86_64
>         case VIDIOC_DQEVENT32:
>                 return put_v4l2_event32(parg, arg);
> +#ifdef CONFIG_COMPAT_32BIT_TIME
>         case VIDIOC_DQEVENT32_TIME32:
>                 return put_v4l2_event32_time32(parg, arg);
> +#endif
>  #endif
>         }
>         return 0;

I think this change requires adding another #ifdef around the
put_v4l2_event32_time32() definition, to avoid an "unused function"
warning. The #ifdef was already missing in the original version, but I
agree it makes sense to add it.

As you suggested earlier, I will resend the fixed series after -rc1
is out.

       Arnd
