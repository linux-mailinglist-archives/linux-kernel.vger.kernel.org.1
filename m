Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294BB2BBF27
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 14:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKUNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 08:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgKUNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:10:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91356C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 05:10:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l11so17470218lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telliq.com; s=google;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wyyXlZOdGsqMQlWFF4RFXmu5nRjaX3Xs6qIF/S+qrVc=;
        b=mVJ3xoAEhjFY1nPmSDsbPmThRCD3QE+gtRluawX6YM3T9Tp05Awgd2RglaZ8v1CZ6m
         D9ulXSfjAdpXrikN7arRkayuDiXFRsrMn4hAebjszhyf38J6Elnk8EVF7oQaHrRzHPx4
         MadwsENeOWkYb8L7Y+lCb6ZVojIoTi1k2mqScRpIlOB4Dpjjx1u5pzNQsO9orrl4xhCq
         Yo75xDHWX7EreOM3tMykHJersnT7y/OWLMe3Ukn3rB9xSzEkiwTYo7c3bLm92vx+Ay9l
         L6vEvOKTDC2mqgZmfTLKMAM8sZjQ694cVwHcxwxE6qoKrD0sHJMQjUeIOTGmmumof6RV
         IT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=wyyXlZOdGsqMQlWFF4RFXmu5nRjaX3Xs6qIF/S+qrVc=;
        b=WBtZntKDEzcVK3TRuMzDYsf8pcxT4UWwWJ+H0brMLPcNYNP5n5/fUGk+hcfeOilXbq
         or113XEkh0VziZkAQaX2zglcZ8eu/aY7CZilkb9cP5/3U/wUJTjGLqWqs5IM5NDDGCpu
         nLo8NK2jh55nu7VkvEg/J4oaSIr3gzAhFnTgPSvMRh09DvMohSSaZMfQGzaY7xhghwhb
         q3CTAgvqn0pbqx8HG6TPsRLMAJsuHR15RS+goZD1BMwXZZCk6HSUZm2KXjaGwfMa2zc0
         NCyYlwRe/nANvpl5A/AGWyX1ZzRlRyjDhqjuvWW2ZP40CLQt3QWZ8mG6w9WhfWksHb9Z
         M73w==
X-Gm-Message-State: AOAM533pC0UrmX/tmOgUwXpnxYpAOPrMMsfcFfcM5gmCCXZ3hM4nhu4V
        Rek13mzVecEqKwL8TL4daaypFrkc0MyJdjwV
X-Google-Smtp-Source: ABdhPJzeCBlg6BgO8NEY2XIjeZGvecNZKZL3B6k5fvDZ4Ktp8bO4X/IwPAN4C/EtL+jHT/yTQpi+OQ==
X-Received: by 2002:a19:8353:: with SMTP id f80mr8914943lfd.348.1605964201762;
        Sat, 21 Nov 2020 05:10:01 -0800 (PST)
Received: from [192.168.53.116] (h77-53-209-86.cust.a3fiber.se. [77.53.209.86])
        by smtp.gmail.com with ESMTPSA id q5sm605162ljc.46.2020.11.21.05.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 05:10:01 -0800 (PST)
Subject: arm: lockdep complaining about static memory allocations
From:   Jan Kardell <jan.kardell@telliq.com>
To:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <a669a3e0-e87e-d4f8-fec7-2b445fc9affb@telliq.com>
Cc:     Russell King <linux@armlinux.org.uk>
Message-ID: <c28a67ba-0d10-75d5-516c-b494f927eeaf@telliq.com>
Date:   Sat, 21 Nov 2020 14:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <a669a3e0-e87e-d4f8-fec7-2b445fc9affb@telliq.com>
Content-Type: multipart/mixed;
 boundary="------------C498ABEC954CF09DB2F7BBCD"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C498ABEC954CF09DB2F7BBCD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Jan Kardell skrev:
> Hi,
>
> I'm lifting our old barrier_braker code on an omap am3552 custom 
> board, and building it on master per 13 november. I currently run it 
> as an zImage-initramfs, but the board normally uses ubifs on nand 
> flash. I get exceptions logged to dmesg, included snippets from the 
> logs  as attachment. I also saw it with an older kernel, 5.4.68 from 
> september. I'm not sure how to debug this and would be happy if 
> someone can point me in the right direction. It looks to me it is 
> something wrong with allocating/freeing net devices in the kernel. 
> Maybe there are OpenWrt patches affecting this?
>
> Regards
> //Jan

Turns out this is not an OpenWrt thing. After enabling CONFIG_PREEMT i 
started to see allocation of net devices in the memory that previously 
was initmem, and lockdep detect that as static memory. To linux 5.2 a 
patch for s390 in commit 7a5da02de8d6eafba99556f8c98e5313edebb449 added 
the function arch_is_kernel_initmem_freed(). It has later been added for 
powerpc and x86 too. I now believe that is needed for arm as well. 
Though I don't know the inner workings of memory management so I don't 
know if an identical solution as s390 and powerpc will do for arm. The 
commit message for s390 says "virt == phys", but that seems not to be 
the case for my arm system.

I did a "dummy" arch_is_kernel_initmem_freed() with a printk to verify 
that the address is in the initmem area:

|[ 73.966965] Address 0xc0e6e630 is in initmem! [ 73.978934] 
------------[ cut here ]------------ [ 74.001003] WARNING: CPU: 0 PID: 
2008 at kernel/locking/lockdep.c:1119 alloc_netdev_mqs+0xb4/0x3b0|


This also makes me wonder if more archs needs this and maybe a more 
general solution, but that's definitely out of my league...

//Jan

-- 

"I have always wished for my computer to be as easy to use as my telephone; my wish has come true because I can no longer figure out how to use my telephone."
- Bjarne Stroustrup


--------------C498ABEC954CF09DB2F7BBCD
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-5.4.75.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-5.4.75.txt"

WyAgIDkyLjE2ODc4OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tClsg
ICA5Mi4xOTg5ODldIFdBUk5JTkc6IENQVTogMCBQSUQ6IDIwMTUgYXQga2VybmVsL2xvY2tp
bmcvbG9ja2RlcC5jOjExMTkgYWxsb2NfbmV0ZGV2X21xcysweGI0LzB4M2IwClsgICA5Mi4y
MzAzODRdIE1vZHVsZXMgbGlua2VkIGluOiBwcHBvZSBwcHBfYXN5bmMgb3B0aW9uIHVzYl93
d2FuIHBwcG94IHBwcF9nZW5lcmljIHBsMjMwMyBpcHRfUkVKRUNUIGZ0ZGlfc2lvIGNwMjEw
eCB4dF90aW1lIHh0X3RjcHVkcCB4dF9zdGF0ZSB4dF9yZWNlbnQgeHRfcG9saWN5IHh0X25h
dCB4dF9tdWx0aXBvcnQgeHRfbWFyayB4dF9tYWMgeHRfbGltaXQgeHRfaGVscGVyIHh0X2Vz
cCB4dF9jb25udHJhY2sgeHRfY29ubm1hcmsgeHRfY29ubmxpbWl0IHh0X2Nvbm5ieXRlcyB4
dF9jb21tZW50IHh0X1RDUE1TUyB4dF9SRURJUkVDVCB4dF9NQVNRVUVSQURFIHh0X0xPRyB1
c2JzZXJpYWwgc2xoYyBuZl9yZWplY3RfaXB2NCBuZl9sb2dfaXB2NCBuZl9mbG93X3RhYmxl
X2h3IG5mX2Zsb3dfdGFibGUgbmZfY29ubnRyYWNrX3J0Y2FjaGUgbmZfY29ubnRyYWNrX25l
dGxpbmsgbmZfY29ubmNvdW50IGlwdGFibGVfbmF0IGlwdGFibGVfbWFuZ2xlIGlwdGFibGVf
ZmlsdGVyIGlwdF9haCBpcF90YWJsZXMgY2RjX2FjbSB0cHM2NTIxN19wb3dlcm9mZiB4dF9z
ZXQgaXBfc2V0X2xpc3Rfc2V0IGlwX3NldF9oYXNoX25ldHBvcnRuZXQgaXBfc2V0X2hhc2hf
bmV0cG9ydCBpcF9zZXRfaGFzaF9uZXRuZXQgaXBfc2V0X2hhc2hfbmV0aWZhY2UgaXBfc2V0
X2hhc2hfbmV0IGlwX3NldF9oYXNoX21hYyBpcF9zZXRfaGFzaF9pcHBvcnRuZXQgaXBfc2V0
X2hhc2hfaXBwb3J0aXAgaXBfc2V0X2hhc2hfaXBwb3J0IGlwX3NldF9oYXNoX2lwbWFyayBp
cF9zZXRfaGFzaF9pcCBpcF9zZXRfYml0bWFwX3BvcnQgaXBfc2V0X2JpdG1hcF9pcG1hYyBp
cF9zZXRfYml0bWFwX2lwIGlwX3NldCBuZm5ldGxpbmsgaXA2dGFibGVfbmF0IG5mX25hdCBu
Zl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgaXA2dF9OUFQgbmZf
bG9nX2lwdjYgbmZfbG9nX2NvbW1vbiBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFibGVfZmlsdGVy
IGlwNl90YWJsZXMgaXA2dF9SRUpFQ1QKWyAgIDkyLjIzMDY4M10gIHhfdGFibGVzIG5mX3Jl
amVjdF9pcHY2IGlwaXAgdHVubmVsNCBpcF90dW5uZWwgbmxzX3V0ZjggbmxzX2lzbzg4NTlf
MTUgZWNkaF9nZW5lcmljIGVjYyBjcnlwdG9fdXNlciBhbGdpZl9za2NpcGhlciBhbGdpZl9y
bmcgYWxnaWZfaGFzaCBhbGdpZl9hZWFkIGFmX2FsZyBrcHAgY21hYyBhcmM0IHVzYl9zdG9y
YWdlIG1paQpbICAgOTIuNTU5ODIzXSBDUFU6IDAgUElEOiAyMDE1IENvbW06IG5ldGlmZCBO
b3QgdGFpbnRlZCA1LjQuNzUgIzAKWyAgIDkyLjU2NjA4M10gSGFyZHdhcmUgbmFtZTogR2Vu
ZXJpYyBBTTMzWFggKEZsYXR0ZW5lZCBEZXZpY2UgVHJlZSkKWyAgIDkyLjU3MjUzOF0gWzxj
MDEwZTY1ND5dICh1bndpbmRfYmFja3RyYWNlKSBmcm9tIFs8YzAxMGIzZDg+XSAoc2hvd19z
dGFjaysweDEwLzB4MTQpClsgICA5Mi41ODA3MDVdIFs8YzAxMGIzZDg+XSAoc2hvd19zdGFj
aykgZnJvbSBbPGMwNzdmYjUwPl0gKGR1bXBfc3RhY2srMHg5NC8weGE4KQpbICAgOTIuNTg4
MzI0XSBbPGMwNzdmYjUwPl0gKGR1bXBfc3RhY2spIGZyb20gWzxjMDEyOTQxMD5dIChfX3dh
cm4rMHhiYy8weGQ4KQpbICAgOTIuNTk1NTY0XSBbPGMwMTI5NDEwPl0gKF9fd2FybikgZnJv
bSBbPGMwMTI5NDdjPl0gKHdhcm5fc2xvd3BhdGhfZm10KzB4NTAvMHg5NCkKWyAgIDkyLjYw
MzQ1Nl0gWzxjMDEyOTQ3Yz5dICh3YXJuX3Nsb3dwYXRoX2ZtdCkgZnJvbSBbPGMwNjBkZTY0
Pl0gKGFsbG9jX25ldGRldl9tcXMrMHhiNC8weDNiMCkKWyAgIDkyLjYxMjM1N10gWzxjMDYw
ZGU2ND5dIChhbGxvY19uZXRkZXZfbXFzKSBmcm9tIFs8YzA3M2JhMDQ+XSAoYnJfYWRkX2Jy
aWRnZSsweDI4LzB4NzApClsgICA5Mi42MjA3ODNdIFs8YzA3M2JhMDQ+XSAoYnJfYWRkX2Jy
aWRnZSkgZnJvbSBbPGMwNzNkOTQ0Pl0gKGJyX2lvY3RsX2RldmljZWxlc3Nfc3R1YisweDIw
Yy8weDQwOCkKWyAgIDkyLjYzMDEyMl0gWzxjMDczZDk0ND5dIChicl9pb2N0bF9kZXZpY2Vs
ZXNzX3N0dWIpIGZyb20gWzxjMDVmMGRkND5dIChzb2NrX2lvY3RsKzB4MjQ4LzB4NWFjKQpb
ICAgOTIuNjM5MTg0XSBbPGMwNWYwZGQ0Pl0gKHNvY2tfaW9jdGwpIGZyb20gWzxjMDIzZDdk
Yz5dIChkb192ZnNfaW9jdGwrMHhhMC8weDkxOCkKWyAgIDkyLjY0NzA2MF0gWzxjMDIzZDdk
Yz5dIChkb192ZnNfaW9jdGwpIGZyb20gWzxjMDIzZTBiMD5dIChrc3lzX2lvY3RsKzB4NWMv
MHg4MCkKWyAgIDkyLjY1NDg0M10gWzxjMDIzZTBiMD5dIChrc3lzX2lvY3RsKSBmcm9tIFs8
YzAxMDEwMDA+XSAocmV0X2Zhc3Rfc3lzY2FsbCsweDAvMHg1NCkKWyAgIDkyLjY2Mjg5NF0g
RXhjZXB0aW9uIHN0YWNrKDB4YzBlODFmYTggdG8gMHhjMGU4MWZmMCkKWyAgIDkyLjY2ODIx
Nl0gMWZhMDogICAgICAgICAgICAgICAgICAgYjZmMDEyODAgYjZmMDEyZTAgMDAwMDAwMDgg
MDAwMDg5YTAgYjZmMDEyZTAgYmU5OTJhMTAKWyAgIDkyLjY3NjgyMV0gMWZjMDogYjZmMDEy
ODAgYjZmMDEyZTAgYjZmNGFmMjAgMDAwMDAwMzYgYmU5OTJiMzggYjZmNGFkYjAgMDAwMmU2
OGYgYjZmNGFmNDQKWyAgIDkyLjY4NTQyMl0gMWZlMDogMDAwM2ZkMmMgYmU5OTI5ZjggMDAw
MWU3NzggYjZmYTg4NDQKWyAgIDkyLjg0NTk3MF0gLS0tWyBlbmQgdHJhY2UgYWY2OTdiMjE3
MDhmYzI0YSBdLS0tCgpbICA4MDYuMTkyNjk4XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0t
LS0tLS0tLS0tLS0KWyAgODA2LjE5NzY0NF0gV0FSTklORzogQ1BVOiAwIFBJRDogMjYwNiBh
dCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTE4OCBmcmVlX25ldGRldisweGE4LzB4MTA4
ClsgIDgwNi4yNDEyMTZdIE1vZHVsZXMgbGlua2VkIGluOiBwcHBvZSBwcHBfYXN5bmMgb3B0
aW9uIHVzYl93d2FuIHBwcG94IHBwcF9nZW5lcmljIHBsMjMwMyBpcHRfUkVKRUNUIGZ0ZGlf
c2lvIGNwMjEweCB4dF90aW1lIHh0X3RjcHVkcCB4dF9zdGF0ZSB4dF9yZWNlbnQgeHRfcG9s
aWN5IHh0X25hdCB4dF9tdWx0aXBvcnQgeHRfbWFyayB4dF9tYWMgeHRfbGltaXQgeHRfaGVs
cGVyIHh0X2VzcCB4dF9jb25udHJhY2sgeHRfY29ubm1hcmsgeHRfY29ubmxpbWl0IHh0X2Nv
bm5ieXRlcyB4dF9jb21tZW50IHh0X1RDUE1TUyB4dF9SRURJUkVDVCB4dF9NQVNRVUVSQURF
IHh0X0xPRyB1c2JzZXJpYWwgc2xoYyBuZl9yZWplY3RfaXB2NCBuZl9sb2dfaXB2NCBuZl9m
bG93X3RhYmxlX2h3IG5mX2Zsb3dfdGFibGUgbmZfY29ubnRyYWNrX3J0Y2FjaGUgbmZfY29u
bnRyYWNrX25ldGxpbmsgbmZfY29ubmNvdW50IGlwdGFibGVfbmF0IGlwdGFibGVfbWFuZ2xl
IGlwdGFibGVfZmlsdGVyIGlwdF9haCBpcF90YWJsZXMgY2RjX2FjbSB0cHM2NTIxN19wb3dl
cm9mZiB4dF9zZXQgaXBfc2V0X2xpc3Rfc2V0IGlwX3NldF9oYXNoX25ldHBvcnRuZXQgaXBf
c2V0X2hhc2hfbmV0cG9ydCBpcF9zZXRfaGFzaF9uZXRuZXQgaXBfc2V0X2hhc2hfbmV0aWZh
Y2UgaXBfc2V0X2hhc2hfbmV0IGlwX3NldF9oYXNoX21hYyBpcF9zZXRfaGFzaF9pcHBvcnRu
ZXQgaXBfc2V0X2hhc2hfaXBwb3J0aXAgaXBfc2V0X2hhc2hfaXBwb3J0IGlwX3NldF9oYXNo
X2lwbWFyayBpcF9zZXRfaGFzaF9pcCBpcF9zZXRfYml0bWFwX3BvcnQgaXBfc2V0X2JpdG1h
cF9pcG1hYyBpcF9zZXRfYml0bWFwX2lwIGlwX3NldCBuZm5ldGxpbmsgaXA2dGFibGVfbmF0
IG5mX25hdCBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgaXA2
dF9OUFQgbmZfbG9nX2lwdjYgbmZfbG9nX2NvbW1vbiBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFi
bGVfZmlsdGVyIGlwNl90YWJsZXMgaXA2dF9SRUpFQ1QKWyAgODA2LjI0MTg0Nl0gIHhfdGFi
bGVzIG5mX3JlamVjdF9pcHY2IGlwaXAgdHVubmVsNCBpcF90dW5uZWwgbmxzX3V0Zjggbmxz
X2lzbzg4NTlfMTUgZWNkaF9nZW5lcmljIGVjYyBjcnlwdG9fdXNlciBhbGdpZl9za2NpcGhl
ciBhbGdpZl9ybmcgYWxnaWZfaGFzaCBhbGdpZl9hZWFkIGFmX2FsZyBrcHAgY21hYyBhcmM0
IHVzYl9zdG9yYWdlIG1paQpbICA4MDYuNDgzMDQxXSBDUFU6IDAgUElEOiAyNjA2IENvbW06
IHBwcGQgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDUuNC43NSAjMApbICA4MDYuNDkw
NTc0XSBIYXJkd2FyZSBuYW1lOiBHZW5lcmljIEFNMzNYWCAoRmxhdHRlbmVkIERldmljZSBU
cmVlKQpbICA4MDYuNDk3MDMzXSBbPGMwMTBlNjU0Pl0gKHVud2luZF9iYWNrdHJhY2UpIGZy
b20gWzxjMDEwYjNkOD5dIChzaG93X3N0YWNrKzB4MTAvMHgxNCkKWyAgODA2LjUwNTE5Nl0g
WzxjMDEwYjNkOD5dIChzaG93X3N0YWNrKSBmcm9tIFs8YzA3N2ZiNTA+XSAoZHVtcF9zdGFj
aysweDk0LzB4YTgpClsgIDgwNi41MTI4MTVdIFs8YzA3N2ZiNTA+XSAoZHVtcF9zdGFjaykg
ZnJvbSBbPGMwMTI5NDEwPl0gKF9fd2FybisweGJjLzB4ZDgpClsgIDgwNi41MjAwNTNdIFs8
YzAxMjk0MTA+XSAoX193YXJuKSBmcm9tIFs8YzAxMjk0N2M+XSAod2Fybl9zbG93cGF0aF9m
bXQrMHg1MC8weDk0KQpbICA4MDYuNTI3OTQyXSBbPGMwMTI5NDdjPl0gKHdhcm5fc2xvd3Bh
dGhfZm10KSBmcm9tIFs8YzA2MGNkZTg+XSAoZnJlZV9uZXRkZXYrMHhhOC8weDEwOCkKWyAg
ODA2LjUzNjQwNl0gWzxjMDYwY2RlOD5dIChmcmVlX25ldGRldikgZnJvbSBbPGJmMjkzZGU4
Pl0gKHBwcF9yZWxlYXNlKzB4ODQvMHg5YyBbcHBwX2dlbmVyaWNdKQpbICA4MDYuNTQ1NTc1
XSBbPGJmMjkzZGU4Pl0gKHBwcF9yZWxlYXNlIFtwcHBfZ2VuZXJpY10pIGZyb20gWzxjMDIy
YjU5Yz5dIChfX2ZwdXQrMHg4OC8weDIyMCkKWyAgODA2LjU1NDI5NV0gWzxjMDIyYjU5Yz5d
IChfX2ZwdXQpIGZyb20gWzxjMDE0NmNhYz5dICh0YXNrX3dvcmtfcnVuKzB4OGMvMHhhOCkK
WyAgODA2LjU2MTgxMF0gWzxjMDE0NmNhYz5dICh0YXNrX3dvcmtfcnVuKSBmcm9tIFs8YzAx
MGE3MTA+XSAoZG9fd29ya19wZW5kaW5nKzB4YTAvMHg1MjgpClsgIDgwNi41NzAyMzNdIFs8
YzAxMGE3MTA+XSAoZG9fd29ya19wZW5kaW5nKSBmcm9tIFs8YzAxMDEwNmM+XSAoc2xvd193
b3JrX3BlbmRpbmcrMHhjLzB4MjApClsgIDgwNi41Nzg4MzBdIEV4Y2VwdGlvbiBzdGFjaygw
eGMzMDM5ZmIwIHRvIDB4YzMwMzlmZjgpClsgIDgwNi41ODQxNTBdIDlmYTA6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwClsgIDgwNi41OTI3NTRdIDlmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwNGQw
MDQwIDAwMDAwMDA2IDAwNGQzNzMwIDAwMDAwMDA0IDAwNGUxOTk0IDAwMDAwMDAwClsgIDgw
Ni42MDEzNTZdIDlmZTA6IGJlYTI2YWM4IGJlYTI2YWI4IGI2ZjQ1NTM4IGI2ZjQ0OWY4IDYw
MDAwMDEwIDAwMDAwMDBmClsgIDgwNi43NzUyMzFdIC0tLVsgZW5kIHRyYWNlIGFmNjk3YjIx
NzA4ZmMyNGIgXS0tLQoK
--------------C498ABEC954CF09DB2F7BBCD--
