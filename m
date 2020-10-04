Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB05282BCE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJDQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJDQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 12:21:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB646C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 09:21:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so861930ljj.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3kQo4EExdoZyDCPFbYDZDuKE8PFg29IHVHKt47FaDY=;
        b=ZOyUdITyHDcTf/ctxnVkUZYmmsSOEeSELnP8Ur3q4wO8/8fAJpX86pnhC3fCAj8kUZ
         5XJIIDesXNl+SPlyM6pCFSFAkv1aJ6EjDAAiOSL1yN7YvxbDJyD2kuHVxpxWGxjsWeI7
         rgIMklegBETF42WkG446dDM7KC3FWcOOUzTlgYzuFSq50lIv9SjHs4nb7wI3NtpxBupI
         ytwyUMAUN89xBtDVmehHJryeNGDVFoSBhjukfOlQ5qBDc7Xxny8ammWQfihed8998RBh
         jgvbz7XV46gGfmKTeoxRFAXxvLX/JrsQqgYHQ2aa1wz9NmRBxtsmH9Ba+9PqautKf8uJ
         7F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3kQo4EExdoZyDCPFbYDZDuKE8PFg29IHVHKt47FaDY=;
        b=od2DQxxiBBUG6DIbRObBFh5kFFHgg8jn5AqRenQQ84Vty4ovD8Eh1c6GV5r1iIlq+d
         LdABdQChssueRFkdfr+zXmmfGwLDk0ceoIAVGsgtI203zdmmrvWKQINg4ncoyYNNsG11
         Dl7TYeGvuacp9ajik3YPt0qUK8irFNNflPdtz9GDRDrr4Lu+EO/PfO+vou3KCS0LMPMj
         LqUV6aaOWqoQmTLs6x9FbNiHUSX4AkiRqDA0fAotREJ1FtMPNGMyKBbet9qT1K+TbcZr
         74BT7xGLJCfHfWzvV6JopwNn6sm4gO9Ng6xuCGbLhaalEvj7SUcU/6VCCiNGqQI7r7vk
         pq2A==
X-Gm-Message-State: AOAM532zCO1Qpe2XNpe8TW1j7RIgJxAUFhtS6nJTvM6Ym15KxbneJqTX
        H1b9ESgC8wYKQMUd2WMSYfIrxNhaE2zE7hQCuvO2w8DoFpdSbw==
X-Google-Smtp-Source: ABdhPJwL6louNaxSPDm0cJ13qVKOldHVYa1w+1ltV+QFHr7F51MUFb/Pvm93sZN/HlG2+wr+9Old0LuKOnrETJbSpiU=
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr2826023ljo.307.1601828484203;
 Sun, 04 Oct 2020 09:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200920113808.22223-1-vichy.kuo@gmail.com> <20200920113808.22223-2-vichy.kuo@gmail.com>
 <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com> <20201002134532.GA3419175@kroah.com>
In-Reply-To: <20201002134532.GA3419175@kroah.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Mon, 5 Oct 2020 00:21:12 +0800
Message-ID: <CAOVJa8HZCmy0s-H7rPVTgi6X1uYZ82YjdPHe3-a4=D+qLgi7Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: platform: provide devm_platform_iounremap_resource
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cae8c205b0dac1df"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cae8c205b0dac1df
Content-Type: text/plain; charset="UTF-8"

hi Greg:
> Please resend, I can't take patches off of a random web site.
> Now lore.kernel.org I could take them from :)

Please refer to the attachments and links on lore.kernel.org.

https://lore.kernel.org/lkml/20200920113808.22223-1-vichy.kuo@gmail.com
https://lore.kernel.org/lkml/20200920113808.22223-2-vichy.kuo@gmail.com

Appreciate your help,

--000000000000cae8c205b0dac1df
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-lib-devres-provide-devm_iounremap_resource.patch"
Content-Disposition: attachment; 
	filename="0001-lib-devres-provide-devm_iounremap_resource.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kfvant3f0>
X-Attachment-Id: f_kfvant3f0

RnJvbSBiMTQxZDUzNzkwNGI3MWI4MDI3NzBkOWMwZmMzNzg3Yjk4YzVjZjcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBwaWVycmUgS3VvIDx2aWNoeS5rdW9AZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE4IEF1ZyAyMDIwIDIzOjA1OjAwICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIGxp
YjogZGV2cmVzOiBwcm92aWRlIGRldm1faW91bnJlbWFwX3Jlc291cmNlKCkKCkRyaXZlciBkb2Vz
bid0IGhhdmUgYSBzaW5nbGUgaGVscGVyIGZ1bmN0aW9uIHRvIHJlbGVhc2UgbWVtcm95CmFsbG9j
YXRlZCBieSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKS4gVGhhdCBtZWFuIGl0IG5lZWRzIHJlc3Bl
Y3RpdmVseQp0byBjYWxsIGRldm1fcmVsZWFzZV9tZW1fcmVnaW9uKCkgYW5kIGRldm1faW91bm1h
cCgpIGZvciBtZW1vcnkgcmVsZWFzZS4KClRoaXMgcGF0Y2ggY3JlYXRlcyBhIGhlbHBlciwgZGV2
bV9pb3VucmVtYXBfcmVzb3VyY2UoKSwgdG8gY29tYmluZSBhYm92ZQpvcGVyYXRpb25zLgoKU2ln
bmVkLW9mZi1ieTogcGllcnJlIEt1byA8dmljaHkua3VvQGdtYWlsLmNvbT4KLS0tCiBpbmNsdWRl
L2xpbnV4L2RldmljZS5oIHwgIDIgKysKIGxpYi9kZXZyZXMuYyAgICAgICAgICAgfCAyNSArKysr
KysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oIGIvaW5jbHVkZS9saW51eC9kZXZp
Y2UuaAppbmRleCA5ZTZlYTg5MzFhNTIuLjMzZWM3ZTU0YzFhOSAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9kZXZpY2UuaAorKysgYi9pbmNsdWRlL2xpbnV4L2RldmljZS5oCkBAIC0yNDAsNiAr
MjQwLDggQEAgdm9pZCBkZXZtX2ZyZWVfcGFnZXMoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25l
ZCBsb25nIGFkZHIpOwogCiB2b2lkIF9faW9tZW0gKmRldm1faW9yZW1hcF9yZXNvdXJjZShzdHJ1
Y3QgZGV2aWNlICpkZXYsCiAJCQkJICAgIGNvbnN0IHN0cnVjdCByZXNvdXJjZSAqcmVzKTsKK3Zv
aWQgZGV2bV9pb3VucmVtYXBfcmVzb3VyY2Uoc3RydWN0IGRldmljZSAqZGV2LAorCQkJICAgICBj
b25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgdm9pZCBfX2lvbWVtICphZGRyKTsKIHZvaWQgX19p
b21lbSAqZGV2bV9pb3JlbWFwX3Jlc291cmNlX3djKHN0cnVjdCBkZXZpY2UgKmRldiwKIAkJCQkg
ICAgICAgY29uc3Qgc3RydWN0IHJlc291cmNlICpyZXMpOwogCmRpZmYgLS1naXQgYS9saWIvZGV2
cmVzLmMgYi9saWIvZGV2cmVzLmMKaW5kZXggZWJiMTU3M2Q5YWUzLi5jZGRhMGNkMGEyNjMgMTAw
NjQ0Ci0tLSBhL2xpYi9kZXZyZXMuYworKysgYi9saWIvZGV2cmVzLmMKQEAgLTExMyw2ICsxMTMs
MzEgQEAgdm9pZCBkZXZtX2lvdW5tYXAoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0g
KmFkZHIpCiB9CiBFWFBPUlRfU1lNQk9MKGRldm1faW91bm1hcCk7CiAKKy8qKgorICogZGV2bV9p
b3VucmVtYXBfcmVzb3VyY2UoKSAtIHJlbGVhc2UgbWVtIHJlZ2lvbiwgYW5kIHVucmVtYXAgYWRk
cmVzcworICogQGRldjogZ2VuZXJpYyBkZXZpY2UgdG8gaGFuZGxlIHRoZSByZXNvdXJjZSBmb3IK
KyAqIEByZXM6IHJlc291cmNlIG9mIG1lbSByZWdpb24gdG8gYmUgcmVsZWFzZQorICogQGFkZHI6
IGFkZHJlc3MgdG8gdW5tYXAKKyAqCisgKiBSZWxlYXNlIG1lbW9yeSByZWdpb24gYW5kIHVubWFw
IGFkZHJlc3MuCisgKi8KK3ZvaWQgZGV2bV9pb3VucmVtYXBfcmVzb3VyY2Uoc3RydWN0IGRldmlj
ZSAqZGV2LAorCQkJICAgICBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgdm9pZCBfX2lvbWVt
ICphZGRyKQoreworCXJlc291cmNlX3NpemVfdCBzaXplOworCisJQlVHX09OKCFkZXYpOworCWlm
ICghcmVzIHx8IHJlc291cmNlX3R5cGUocmVzKSAhPSBJT1JFU09VUkNFX01FTSkgeworCQlkZXZf
ZXJyKGRldiwgImludmFsaWQgcmVzb3VyY2VcbiIpOworCQlyZXR1cm47CisJfQorCisJc2l6ZSA9
IHJlc291cmNlX3NpemUocmVzKTsKKwlkZXZtX3JlbGVhc2VfbWVtX3JlZ2lvbihkZXYsIHJlcy0+
c3RhcnQsIHNpemUpOworCWRldm1faW91bm1hcChkZXYsIGFkZHIpOworfQorRVhQT1JUX1NZTUJP
TChkZXZtX2lvdW5yZW1hcF9yZXNvdXJjZSk7CisKIHN0YXRpYyB2b2lkIF9faW9tZW0gKgogX19k
ZXZtX2lvcmVtYXBfcmVzb3VyY2Uoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgcmVz
b3VyY2UgKnJlcywKIAkJCWVudW0gZGV2bV9pb3JlbWFwX3R5cGUgdHlwZSkKLS0gCjIuMTcuMQoK
--000000000000cae8c205b0dac1df
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-driver-core-platform-provide-devm_platform_iounremap.patch"
Content-Disposition: attachment; 
	filename="0002-driver-core-platform-provide-devm_platform_iounremap.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kfvant451>
X-Attachment-Id: f_kfvant451

RnJvbSAzM2FmYTMxNWMzYzk0MWIzMDNlOWIzMTUyNTUyMDEwYWQyNjZlYmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBwaWVycmUgS3VvIDx2aWNoeS5rdW9AZ21haWwuY29tPgpEYXRl
OiBXZWQsIDE5IEF1ZyAyMDIwIDE1OjU3OjA1ICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRy
aXZlciBjb3JlOiBwbGF0Zm9ybTogcHJvdmlkZQogZGV2bV9wbGF0Zm9ybV9pb3VucmVtYXBfcmVz
b3VyY2UKCkNvbWJpbmUgcGxhdGZvcm1fZ2V0X3Jlc291cmNlKCkgYW5kIGRldm1faW91bnJlbWFw
X3Jlc291cmNlKCkgdG8gcmVsZWFzZQp0aGUgaW9tZW0gYWxsb2NhdGVkIGJ5IGRldm1fcGxhdGZv
cm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCkuCgpTaWduZWQtb2ZmLWJ5OiBwaWVycmUgS3Vv
IDx2aWNoeS5rdW9AZ21haWwuY29tPgotLS0KIGRyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jICAgICAg
ICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcGxhdGZvcm1f
ZGV2aWNlLmggfCAgNCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcGxhdGZvcm0uYyBiL2RyaXZlcnMvYmFzZS9wbGF0Zm9y
bS5jCmluZGV4IGU1ZDhhMDUwM2I0Zi4uZTI2NTVjMDA4NzNmIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2Jhc2UvcGxhdGZvcm0uYworKysgYi9kcml2ZXJzL2Jhc2UvcGxhdGZvcm0uYwpAQCAtODQsNiAr
ODQsMzAgQEAgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2Uoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldiwKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGRldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKTsKIAorLyoqCisgKiBkZXZtX3BsYXRmb3JtX2lvdW5y
ZW1hcF9yZXNvdXJjZSAtIGNhbGwgZGV2bV9pb3VucmVtYXBfcmVzb3VyY2UoKSBmb3IgYQorICoJ
CQkJICAgICAgcGxhdGZvcm0gZGV2aWNlIHdpdGggbWVtb3J5IHRoYXQgYWRkciBwb2ludHMgdG8u
CisgKgorICogQHBkZXY6IHBsYXRmb3JtIGRldmljZSB0byB1c2UgYm90aCBmb3IgbWVtb3J5IHJl
c291cmNlIGxvb2t1cCBhcyB3ZWxsIGFzCisgKiAgICAgICAgcmVzb3VyY2UgbWFuYWdlbWVudAor
ICogQGluZGV4OiByZXNvdXJjZSBpbmRleAorICogQGFkZHI6IGFkZHJlc3MgdG8gYmUgdW5tYXAu
CisgKi8KK3ZvaWQKK2Rldm1fcGxhdGZvcm1faW91bnJlbWFwX3Jlc291cmNlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYsCisJCQkJIHVuc2lnbmVkIGludCBpbmRleCwgdm9pZCBfX2lvbWVt
ICphZGRyKQoreworCXN0cnVjdCByZXNvdXJjZSAqcjsKKworCXIgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIGluZGV4KTsKKwlpZiAoIXIpCisJCWRldl9lcnIo
JnBkZXYtPmRldiwKKwkJCSJNRU0gcmVzb3VyY2UgaW5kZXggJWQgbm90IGZvdW5kXG4iLCBpbmRl
eCk7CisJZWxzZQorCQlkZXZtX2lvdW5yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByLCBhZGRy
KTsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKGRldm1fcGxhdGZvcm1faW91bnJlbWFwX3Jlc291cmNl
KTsKKwogLyoqCiAgKiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgLSBjYWxsIGRldm1f
aW9yZW1hcF9yZXNvdXJjZSgpIGZvciBhIHBsYXRmb3JtCiAgKgkJCQkgICAgZGV2aWNlCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RldmljZS5oIGIvaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kZXZpY2UuaAppbmRleCA3N2EyYWFkYTEwNmQuLjc1ZGExNTkzNzY3OSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kZXZpY2UuaAorKysgYi9pbmNsdWRlL2xpbnV4
L3BsYXRmb3JtX2RldmljZS5oCkBAIC02Nyw2ICs2NywxMCBAQCBkZXZtX3BsYXRmb3JtX2lvcmVt
YXBfcmVzb3VyY2Vfd2Moc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKIGV4dGVybiB2b2lk
IF9faW9tZW0gKgogZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LAogCQkJCSAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOworZXh0
ZXJuIHZvaWQKK2Rldm1fcGxhdGZvcm1faW91bnJlbWFwX3Jlc291cmNlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYsCisJCQkJIHVuc2lnbmVkIGludCBpbmRleCwKKwkJCQkgdm9pZCBfX2lv
bWVtICphZGRyKTsKIGV4dGVybiBpbnQgcGxhdGZvcm1fZ2V0X2lycShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICosIHVuc2lnbmVkIGludCk7CiBleHRlcm4gaW50IHBsYXRmb3JtX2dldF9pcnFfb3B0
aW9uYWwoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqLCB1bnNpZ25lZCBpbnQpOwogZXh0ZXJuIGlu
dCBwbGF0Zm9ybV9pcnFfY291bnQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqKTsKLS0gCjIuMTcu
MQoK
--000000000000cae8c205b0dac1df--
