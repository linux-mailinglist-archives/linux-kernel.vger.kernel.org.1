Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAC2EABE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbhAEN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbhAEN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:27:19 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jan 2021 05:26:38 PST
Received: from mail.codevoid.de (mail.codevoid.de [IPv6:2a01:4f8:c2c:9b13::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A9C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:26:38 -0800 (PST)
Received: from mail.codevoid.de (localhost [127.0.0.1])
        by mail.codevoid.de (OpenSMTPD) with ESMTP id 9127e028
        for <linux-kernel@vger.kernel.org>;
        Tue, 5 Jan 2021 14:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=codevoid.de; h=date:from
        :to:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=selector1; bh=DUjPwn49vLO9YGiyf29y
        G8glUfw=; b=XAvUj/G5xW9wd6tsEXu+6SJqVlULBNH1I2SzRdk74HUDu/L37+Sz
        hmYMs4BwJznb1APljxxnux9n26vLR5xgXcAI7NAIgRatx+5unyMNT2xulyiaPLEF
        t+Y7df7F33dIzNFILz5unRmLtPnuWj6lp9x6LQbQtw41qqKL578SNrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=codevoid.de; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=selector1; b=WUUoEFdTp6Q1xo
        DMc8oSf/qoRYCtdSiTekQH+zO5hvsML0aDJapHea3l7Wy4rN5KtIt/pJVpl2CG+H
        Dn6GHwahnm74P1K5sqCAcIT+rY12ApzVBP7WLOZbXE3oJj2U9yfN3msyL4zyzy4b
        tlGSQiTfrSFdVKQ9B6dnvP6UucNq4=
Received: from localhost (p5b151a53.dip0.t-ipconnect.de [91.21.26.83])
        by mail.codevoid.de (OpenSMTPD) with ESMTPSA id 40530dea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 5 Jan 2021 14:19:53 +0100 (CET)
Date:   Tue, 5 Jan 2021 14:19:52 +0100
From:   Stefan Hagen <sh+openbsd-tech@codevoid.de>
To:     linux-kernel@vger.kernel.org
Subject: Fw: Hiding the vim user in amdgpu_vcn.c (typo in comment)
Message-ID: <X/RneNOZ9AKbk8le@puffy.hagen.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Editor: nvi 2.1.3
X-Mailer: Mutt 2.0.4 (2020-12-30)
X-PGP-Fingerprint: CBD3 C468 64B4 6517 E8FB B90F B6BC 2EC5 52BE 43BA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ricardo Mestre wrote:
> Stefan Hagen wrote:
>> I can totally relate to this one.
>>
>> Found after a conversation about muscle memory and grepping the
>> source tree for ":wq".
>>
> This issue is present in upstream [0], please take it with them.
>
> [0] https://sourcegraph.com/github.com/torvalds/linux@30bb5572ce7a8710fa9=
ea720b6ecb382791c9800/-/blob/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c#L131

Forwarding to upstream.
The patch below is for the Linux source tree.

Best Regards,
Stefan


=46rom e4511830bd58ac1508dde86b440a36e15a92b5cc Mon Sep 17 00:00:00 2001
=46rom: c0dev0id <sh+git@codevoid.de>
Date: Tue, 5 Jan 2021 13:50:13 +0100
Subject: [PATCH] drm/amdgpu: fix typo in comment

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 4a77c7424dfc..0c9eeb42d518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -168,7 +168,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
=20
 	/* Bit 20-23, it is encode major and non-zero for new naming convention.
 	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
-	 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLE=
D_FLAG
+	 * convention. Since the latest version minor is 0x5B and DRM_DISABLED_FL=
AG
 	 * is zero in old naming convention, this field is always zero so far.
 	 * These four bits are used to tell which naming convention is present.
 	 */
--=20
2.30.0

