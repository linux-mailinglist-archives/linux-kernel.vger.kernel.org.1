Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DB2D18BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgLGSuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:50:02 -0500
Received: from sonic309-21.consmr.mail.gq1.yahoo.com ([98.137.65.147]:44702
        "EHLO sonic309-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgLGSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1607366924; bh=+HUK5KyDjgCAXO4lpplCtBN5pV22HLCAWYMsVxdaBHk=; h=From:To:Subject:Date:References:From:Subject; b=e9ppLnx4oipZwW+1aHhqpRQSecrMiKgEHv3t7EUi2pQ65OmEAgHQd8GiM1EMMi2aKqORsTP81MKhAtrihnOUYOBE4uDKz1Wf2Gs7FLpjEBD5Tpwt3Nx5CqmpcvjkTMiW+nN3lKnHmACfjVznJKOA22ZmyMtumX56fW9Wda7AYJEDqdxglLptjl5XAyd8C77aJ1W0/2i8shr76CydmvwmLl9fvxvA8lZSLuS5YMRsUM1ADHbeZNyBxIOm50NwLfYajSTYDoJi2lBG+ak/W9OCsEaaiuiK0L6+2vx/GBigT4QOLXdAoQL1OZJfz12m3AzktbWM5NqoRsqT/ZKTHtnJyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607366924; bh=SoyKBF4NEGDq9UI8Y6JtkIwCr6Raw9XpHK/iN0iLEYN=; h=From:To:Subject:Date:From:Subject; b=a1VU+ES3bA7MKUC+fu5Hq/dIIJrbYWqi223CYagiERpk4rWDksTxfmqxLWMsP7MO6aS6ERTWD+f6VAiyulbCrQc5W7fLDZAG5GSU7NyocDaDC2zlbfMUk/4GpA0s0Yr7MMwyeWadBYToAJAx3pRInZsZokCj5HQH11Umt/4qzNYvApd/3q95Eq4sZIliJEuymCul/X6KZBapmHDbysGdR0pSgykB/zn/lcNNFIfwI0feh12ph3rN83K071einsGmjXeFscwe5Sw+ioF0qxuydGzhxOlRiiGKsH4ZeUTehATWFuTxbjy+6uAx6+J09iWmXKxtm8IMobyOPHQiw807Hg==
X-YMail-OSG: 1QAjGKEVM1knIbp0drmWAdyACln4yo97atP5uOzRhnna2awOzHh46dlqpVct6fr
 bSlpbFAi_h9yqyERTbakVVgVZ3gI6sWBhoZ2Stu7C3D0pJECgDUkfMC9pxVLAJosgdPKrYM.Q_lg
 CAQZCKQ_QHjimquUAZSAO0vrrab8SVvzN0jYccsi5ldUnWNZYgVsJ_aXJIM8VFzEU4sDEYa_kLQk
 oxGD0Lg9iwnYvKLmATXIA0QhQQ4XWAFMJhYGxGA7dRyLVnl0D3IQCeK22IYdZN96Sv82olcO7BC1
 iSXPobCjbxvYNTz..Fg2TQN51pEQGKw9OY8u0jTpwf_lEwzi9B2aTjpUY4gotqHIcbXsMnI.UYbd
 Dfn2V2PzDBY5gNj.zSMQnoMkE7wodVTKZE84HW8ctFYIZahkJ7PssNXJaLgAMo1AtXI8E_Kb2F8w
 QRKY0_cJqoQcbNegNURZOy0bIS0tjb6EkTqDBY5kQXkSYnDbKNp9.JF894Pmw7ubWJa5szlfSihM
 WGWoPSEM4Ha3xQXU1UvQxqIVRJHPf2KhzhSzl.N4aHpAf2MGJd3Tx0krFBej7JBP.svsF6EufwDy
 7pC__qHVfRTf5qij1wN9svG44BBrVjaOU7PxCx8BRxOhBJxP.I9jVOsB.9nXs6OM8JSewQTmygi.
 femuZI6EOE5Y1UjD5M5pVjmBmS5rkAA7M.6.ev1fQ4diNuoNzW03lUN1zr8xQbBEC_QtjEL38st5
 SQfNFkrCKvnqZpJURk54JNV5LSMpfa4hWMdrHHRRg644_T4.ONiJx44vyk_SSyqkL7TGe1bA5CCC
 cXuXCmASs.2YqVdTqf3Mt.k8l6iLGTqpPMyh3jM_lwr84Zm7uqb34y17d1jE_b4sv5iJk56nWArZ
 IlQFIg6A9hN5FFs5bp284QlULMDevEjDV28j8SUaXm.NA6oNs_cweYRkE5zzHVxed0FWgTaz26ns
 .1.VCrZITwq9elbc4J.2PguFcZrY.v9y6y5J3UK9JIlERRP8hfZ_xEKFwEiNS2CQsi9vcpTml7mH
 ozoUsLiTBZIoyNeLRl935OXTBXuzrFvJVzU5dM22GYimSUNN78359QKLDLnmvapofs22ujJ_ixF3
 Uuyowp1fk_Ji98rbFLLJnUG0zr49xycTDVDl7iMQqA_mRC4s.HMd0TQwwyh3.6sz.3zamo4Dz5TV
 uXnoApxMsJp4oDC7KJuMfQ0dVtk8offVf11rzR_5fPvwFIDNzdSoiohYjQu9_XtZxHWsd1r7VaDI
 8ABfaoiMFAgKO2.Z0P8aWXvIvx2L7RxZrdClXQWAmC0NvNkEI0TPUNA8de42JwsTuf99LlDoKGkt
 SRoBki5mtUpqhJgRHyKUs772CTnH41bcqixmBeawxQDsdL5SX3.CP9EQHFd9KDM_RQCP_r9HBY2S
 ats3g6gC.eL_wscAdSoFohtqDULTnZtmCy7W4rJCY9ThJ2KpXr5Y.anU7zf0lck9gAzqQ8IUGO.g
 5MO_6FnRzixWZMumowZ7nIhrVH05hBGqBZNx4mGPBl5XHwMm6_WXLw4rp_HzYK.PXB3MdZPFnEXk
 LmK4hLFDV6LbpvVGIIBBBwYAZLaqNtIVFBtznXJ_xLHK2.p0lx9U.BIYTTU48G0fesV7W.DYA7Bz
 .uPsxfrrfLETpt0yZraNtw7Uy7dJLx2uekRJAzJFjZwuITvXT4jMLfbCUa9jpgeYX.ahOCLDZPuo
 88Ho1mnrIK0SJgwvFveQTk0zqFqa0PJ.YON31gqGsvKHd6rpCEbbyh8z8se4Uj40M07gceXNvUBk
 9D1mssIiJjWJHB58knApbhCly.z3x6b._QdNeMGXNq6tmNDcDD4P2YNOSW.oxarrV0ESuGhAg.Tw
 CjcMRMGjZRD_K1K5PB0nkFZqXskOLj1NtF9OIZzfJSIWbawWiQ5dhdEckD37ivmG3ZzTyWvkqVWh
 uE68qa2p5yGAyDSGhebiXZH.XUEVBgy8MKot3g20.dJl.5pZXDQdj71UUgawB1YbuqKc1PVZPo4V
 qPN12yaGxOP9_i7U4_Bj1l9dsnEnpkOqtGOWyiCZVeizXSs0JY8YhkjItrL3rhDmOPOEWI.gt4UX
 IfSqkGMHVdVKtsSLB0y1rC8EfQ44vViEnLXWwXXtVR0fwOW_3FIf7fEH0EUhRANvulkEmcHXAsuj
 xoH.ihmb_yjr94bqkpu7kMlFKNwEgWkDjaBMerMq1l32Lv5eR0PZpgWbkT71pLQpUaU6a65cfyJA
 Nz3fnzYM71DvRQl8XGEVSyPXVKIBwWSKKkOLclsyXfnpfwyec8Bv4vjnw0N6CrhA_zdhOYSnsSC1
 W7pA05knyYqp.QtQg..fqIczPf3nI1Vv1HU5QYUDyg8tPcZag8vLqeZTKLM5tykVXc0o5QuONXbg
 Dbq6FfkDDfJDX_iJXq43R1gc7zHN6Byx73tg4AaD5X7YwqIC6IHuvq0VKjC3KDfryTfS0KN8aHtf
 6y7hWZ3fPkoCjfFlr_vEzRdgBTMXC8gYR7j8QAS6X4cTeMZice2N.uF6UNOZ3ITRuXNJyFb5LPVI
 V5nA4d1dzHx6m5Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 7 Dec 2020 18:48:44 +0000
Received: by smtp406.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e74d225f1b631ac1ef6bdaff31506e61;
          Mon, 07 Dec 2020 18:48:39 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] init: fall back on mounting raw root
Date:   Mon,  7 Dec 2020 13:48:33 -0500
Message-Id: <20201207184835.63538-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201207184835.63538-1-alex_y_xu.ref@yahoo.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

9p/virtio, virtiofs, and others can be mounted with no block device or
userspace helpers.

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 init/do_mounts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index b5f9604d0c98..8aa38ec0bfec 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -568,7 +568,7 @@ void __init mount_root(void)
 	}
 #endif
 #ifdef CONFIG_BLOCK
-	{
+	if (ROOT_DEV != 0) {
 		int err = create_dev("/dev/root", ROOT_DEV);
 
 		if (err < 0)
@@ -576,6 +576,7 @@ void __init mount_root(void)
 		mount_block_root("/dev/root", root_mountflags);
 	}
 #endif
+	mount_block_root(saved_root_name, root_mountflags);
 }
 
 /*
-- 
2.29.2

