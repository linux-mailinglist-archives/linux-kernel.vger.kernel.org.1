Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A212D0D08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLGJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:30:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E3C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:29:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u18so17042240lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ualberta-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D5Vl+TIfc9mte2BSgsT2PPD8x8yA+NOeOEnoj3U/nb4=;
        b=ANB1WPIX1Y+p547DOzlnXy3DHM8u4wDtntNspxRplPULP+JSLRay7B6t341qkBa2qi
         Neb3OAJBQHTmiUhKcsmw1DTb2ZBicOD76r5gCmCVqZCo8ELf0IX+wcsNWa8xcE+adIb+
         foAA932NFEycveZianE1ROxK8BRGH8d1abC64EreJEa/O23AiQXVLA7n0Ib5MdTfdLOY
         14INhl6uyMkTMg0W20QKi7IwBdzA2F2gt7L4Zft6RXFHaSPJ2M7xwS11SQ++M7Ra9TSY
         Wj0cbKGHAb6rsoiFchvH3ouuA90ea4XP+OwB7X+7l3k5RZwXGcGIcU5dTgCsnBmIV+fn
         XLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D5Vl+TIfc9mte2BSgsT2PPD8x8yA+NOeOEnoj3U/nb4=;
        b=PVAnl7PiHBSzbKAYrD07XzeelPYJAKhELk6XSVmlMmOO88sJOZbJukUTKJF44yZA7L
         eQZiUi2buqx6AMvG5R3LArwwEezLmjBzxgiSAoFY6S279cJMZKtHSkdLPG2U9JpL+RB1
         9JVeo26K3PngKT3CTw3ipPLJQPH87mwVl7Z9BGZpjv3c2F/T5TIAkk5xi+xhsjyTv2xS
         PUPzwF4torzLH1Rto6aZcmNL0//08PIJ5ryq8iDV/ckOUGlrb3RnuLaJmAmanXmuiNcr
         91aQ5dIXQlFLRAY+lq5Wp9jq+M22oD3Wh79DPhkvX5g4UVgH7Lg0pdGJA/9Ig7LtZvdw
         14Cw==
X-Gm-Message-State: AOAM5300uonJWFu1abJAP2s6eTRJQr+TMe5Vcm/vZV7QUvbnWZySryKo
        qDs0bxPQmFdqIeIUA4yN4QcunPCqv1rnSZwuuq5CVUFUuLc=
X-Google-Smtp-Source: ABdhPJzX2lZpU0E2Erh/An5zBiqDNloJi5MJWXa/U1GVOV29wnL0gjTeU1xCXH6iyr7I3D0ILp2i8E45gg2VhMC7jmM=
X-Received: by 2002:ac2:5ca1:: with SMTP id e1mr508073lfq.192.1607333390602;
 Mon, 07 Dec 2020 01:29:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJWrxn12rrMtomPUcu4GsDeTe5vpGKsR-F6=hM1Y8a=iAY+gag@mail.gmail.com>
In-Reply-To: <CAJWrxn12rrMtomPUcu4GsDeTe5vpGKsR-F6=hM1Y8a=iAY+gag@mail.gmail.com>
From:   Elias Carter <edcarter@ualberta.ca>
Date:   Mon, 7 Dec 2020 01:29:34 -0800
Message-ID: <CAJWrxn3qCJnVL5QTSyu81CPm35RL3x4qfd7ux3bB3HByfkbPSQ@mail.gmail.com>
Subject: Re: 5.10 RC 7: grub2 out of memory
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="000000000000c8a1bc05b5dc771b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c8a1bc05b5dc771b
Content-Type: text/plain; charset="UTF-8"

Resending grub config since that appeared to be mangled by my mail client:


On Mon, Dec 7, 2020 at 1:16 AM Elias Carter <edcarter@ualberta.ca> wrote:
>
> I just compiled and installed 5.10 RC 7 and got a message from grub2:
> "out of memory, press any key to continue" shortly followed by a
> kernel panic (see attached screenshot).
>
> The 5.4.0-56-generic kernel from Ubuntu works on my machine fine.
>
> Things I have tried so far:
> - setting grub video mode to "console"
> - setting grub video resolution to 800x600
> - regenerating the initramfs for 5.10 RC 7
> - verifying that /boot has free space
> - changing boot mode from UEFI to legacy BIOS
>
> I have attached the following:
> 1.) dmesg ran from using the 5.4 kernel (since I cant boot into 5.10 RC 7)
> 2.) my 5.10 RC 7 kernel .config
> 3.) screenshot of kernel panic after "out of memory" grub2 message
> 4.) my /etc/default/grub
>
> Please let me know if you would like any more information or testing of patches.
>
> Thanks,
> Elias

--000000000000c8a1bc05b5dc771b
Content-Type: text/plain; charset="US-ASCII"; name="grub-config.txt"
Content-Disposition: attachment; filename="grub-config.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kiecp4qh0>
X-Attachment-Id: f_kiecp4qh0

IyBJZiB5b3UgY2hhbmdlIHRoaXMgZmlsZSwgcnVuICd1cGRhdGUtZ3J1YicgYWZ0ZXJ3YXJkcyB0
byB1cGRhdGUKIyAvYm9vdC9ncnViL2dydWIuY2ZnLgojIEZvciBmdWxsIGRvY3VtZW50YXRpb24g
b2YgdGhlIG9wdGlvbnMgaW4gdGhpcyBmaWxlLCBzZWU6CiMgICBpbmZvIC1mIGdydWIgLW4gJ1Np
bXBsZSBjb25maWd1cmF0aW9uJwoKR1JVQl9ERUZBVUxUPTAKR1JVQl9USU1FT1VUX1NUWUxFPWhp
ZGRlbgpHUlVCX1RJTUVPVVQ9MApHUlVCX0RJU1RSSUJVVE9SPWBsc2JfcmVsZWFzZSAtaSAtcyAy
PiAvZGV2L251bGwgfHwgZWNobyBEZWJpYW5gCkdSVUJfQ01ETElORV9MSU5VWF9ERUZBVUxUPSJx
dWlldCBzcGxhc2giCkdSVUJfQ01ETElORV9MSU5VWD0iIgoKIyBVbmNvbW1lbnQgdG8gZW5hYmxl
IEJhZFJBTSBmaWx0ZXJpbmcsIG1vZGlmeSB0byBzdWl0IHlvdXIgbmVlZHMKIyBUaGlzIHdvcmtz
IHdpdGggTGludXggKG5vIHBhdGNoIHJlcXVpcmVkKSBhbmQgd2l0aCBhbnkga2VybmVsIHRoYXQg
b2J0YWlucwojIHRoZSBtZW1vcnkgbWFwIGluZm9ybWF0aW9uIGZyb20gR1JVQiAoR05VIE1hY2gs
IGtlcm5lbCBvZiBGcmVlQlNEIC4uLikKI0dSVUJfQkFEUkFNPSIweDAxMjM0NTY3LDB4ZmVmZWZl
ZmUsMHg4OWFiY2RlZiwweGVmZWZlZmVmIgoKIyBVbmNvbW1lbnQgdG8gZGlzYWJsZSBncmFwaGlj
YWwgdGVybWluYWwgKGdydWItcGMgb25seSkKR1JVQl9URVJNSU5BTD1jb25zb2xlCgojIFRoZSBy
ZXNvbHV0aW9uIHVzZWQgb24gZ3JhcGhpY2FsIHRlcm1pbmFsCiMgbm90ZSB0aGF0IHlvdSBjYW4g
dXNlIG9ubHkgbW9kZXMgd2hpY2ggeW91ciBncmFwaGljIGNhcmQgc3VwcG9ydHMgdmlhIFZCRQoj
IHlvdSBjYW4gc2VlIHRoZW0gaW4gcmVhbCBHUlVCIHdpdGggdGhlIGNvbW1hbmQgYHZiZWluZm8n
CkdSVUJfR0ZYTU9ERT04MDB4NjAwCgpHUlVCX0dGWFBBWUxPQURfTElOVVg9a2VlcAoKIyBVbmNv
bW1lbnQgaWYgeW91IGRvbid0IHdhbnQgR1JVQiB0byBwYXNzICJyb290PVVVSUQ9eHh4IiBwYXJh
bWV0ZXIgdG8gTGludXgKI0dSVUJfRElTQUJMRV9MSU5VWF9VVUlEPXRydWUKCiMgVW5jb21tZW50
IHRvIGRpc2FibGUgZ2VuZXJhdGlvbiBvZiByZWNvdmVyeSBtb2RlIG1lbnUgZW50cmllcwojR1JV
Ql9ESVNBQkxFX1JFQ09WRVJZPSJ0cnVlIgoKIyBVbmNvbW1lbnQgdG8gZ2V0IGEgYmVlcCBhdCBn
cnViIHN0YXJ0CiNHUlVCX0lOSVRfVFVORT0iNDgwIDQ0MCAxIgo=
--000000000000c8a1bc05b5dc771b--
