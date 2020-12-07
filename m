Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3101F2D18BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgLGSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:50:12 -0500
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205]:39023
        "EHLO sonic304-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgLGSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1607366935; bh=sn76C4SZBxRsehpn3BS4ft1oMvJC+pgw5mBwX0AZxTo=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=HqkKAjPTLqAaR7MGQSnv5BD6MvoVdPLXDQC8KPHbhs6kuzV18jvEQm7O08j40+1nUbkzO/UwH88lxyMRQXST/ifCQ9rPLNiTAwpAh26gviFLoJSb8oms0uDjnpu2d4gw/HkDckhwZwJFx53TASVlFcALND13ynv2kKqoA3vpd/kZ8hBv7zntPdNUJOppF9J14XnNsTY9a/c/C27Fq+k/7gvzAe+R4Hs0AiwEur5m/wrtk84KdEfGK5ISEtpeUCFCbLi3b8QX/EQHDlarOfR2yIIJZIBoefodVgNoq9uYf0zYPKZ2z5iBOCajL5qGw/LyNuBxOozXLvS5bVjrew5BuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607366935; bh=OawfeLwdYMigW43uDGYgLLxUuaLhR8fIQmuLTk3d4td=; h=From:To:Subject:Date:From:Subject; b=ujSIHTM54d68+GBWtVVtWg9isDPDHSh/5cOKnlCv+waU+4Ss8Lu46xwgyaQXyD7P996DcW9yhXX8m3bXPI6mQAoB79p15/d+q28xNel7rJnuGyPq7UQm1H3Fp7n4SlScUTo5aHoe9ee2aZcJxYDX5dAZYjbrsRUgs94kXEZEs6KnkkLIU0oiC1yy5nYzsAFV9Rh0gqLtgiOg8IqCzLk9x/TUCWDvBjwu07n4BJnhXvDYvb0rcretnWfCVhvzMJY64/RBMrvN0cG00ukisboFQ5XXs+y3XoEZovN6xrD5E2DYsG2Se2mLOu6mADqt3C9MWGl4cO/6MuGM1enl+0a16w==
X-YMail-OSG: 4ESKiWQVM1lpFhkruvK9opa.4EX764pS3rJNO4t2X2kSFgPzl1.90k1iQtA.9Qu
 .yPe6CGQ3pAcq45t_0vfg4ejyobRY5DkG_0_R0.uOFcbHlz7Y74zq0npMXHmGqwyE38hfdfSJoIx
 7m0ukB8APpZuYMvlcayrc.JNSIFmPIDT2z3eG6sRo.A.QKXbZi4Ze2bz2uDy.v4JAnmYd4awRx2n
 x4njnUh6TvNRNqWsWCyKzy75GvZKbWbrslcp508FpB_7mY1CqrVcSV4j9ziaPPOrjyohPNoNGplD
 hhSMmSPxjvyaZz6p18ejtJLE1iwL3npNL3aCQx8zB4Cu9y45NmEfRrNswOt5Lnakgo8rurGfRLPl
 U9aMKmsTr4JtGHDdVSv.RbLf6gUN5dEm_bbOrHlXDviaZxVDQYOlqNOq5pWEl0qVKZ43VdTOa97X
 2aMCsZ1JxlFWFSySQYOzbILgnAV5fihYsOcjI_jLVNTalONtG4eKkujBI2M9B84.PbExQPibp3E5
 F5EpEr2jqDI1fKXH7S6YwTQGwh8OajD1PpZj8LdXr0fTnqF605sTNZMZGkNfXuMnAB2vyr0HPG2A
 ITHgOrhcvbw2A_g0zCYUFHSNkejwbQ75x16b3Mnul2fP79Jlkua0.qNs2.7EFSzsbLUfOVDfBZJL
 sc59yqFvPethxpyK99fY_L_uhOhdqflKysdCP3BztHZQRAniBiIVVqmIqFIp1aH1KyKbZntYXM6H
 j3KjzxK1nfOO2K2Wmg4y9_yK9rxY2KhLIjmrCaWrX3e.lpFI.D4ZjuphzbmgcB7ca5fZz9gYNSg1
 .kbkqN6uWt3wT3PdzDu5wMTLr58cI5WEnfTLSrBhMuU3sSPqh2evn_kBSbm.VH9rFhoC2gTeWVhI
 khBTz4Z15ZKPek2hs8zr2st59z0xVcfPuN_ABl3CCVatHus7eabA25q41ppG.B6hjDNbg0fsMMLC
 _F8Z62EAEu4UfHhEID5IxHoBxDiBc8GZ.oAqsOsnGYuSq62NBfbXXMCgsD.KlbljXZ_UKEbwIBEZ
 VmzcSmOHXZ5jqmIgM_0WnQHrU5vrQhtipLXSkHj3FkY.Ye.gw1229fMJz.aZQVFU225DMVQ2SFzC
 YbtybqsitNcvznIu4x8RCNlPJPUM78N3jeIqP.7lWBipGEhBl05Hwtj4zHF7LVFaNRot9P1pqnKJ
 p7CE_5b9Enk5f7CkLB_i43kuaEBEDC7RR5hvh8L36RrIKL3u8kM_2LHTUOFaeSeFHiLFrmflA4vh
 ws8zxGBQ9IzhQ.KFQafZ.aQpNTuT3nkzEzLWw_.A0XSRGfudBl1tqDWMwpl6z1LlH48MWQEmBzKm
 qkxsEk4N_Uh4DuI73NkcbVETVo.fIOxoGE7j1LPkjvePGn4vcldBNWf1iedPxRxK.QuV5lnpA5g3
 MYKs6Hf08xTtQaDBAtczo9VgHQMn6YRM5bZ3rT3TjRsFbEqt6cvZjQb9J.x0Muk0Lr9QNZZIBdzF
 ilQrEWNOFxh5aci36kvgBAco2dul9HnPhX3Xr2d1HeR1xaRc1jq6NNmYydHN1lw1MekbgJVFi0a9
 TnzDJJxqeArSO.bJjfNtWhxw_4KrwQbvK6L94iETzNdgzMrUl0uqEcYq.ClMgluQgpKxrH1dJsga
 yRTd3sC5xOeB1TqDVz4AEHL2GxdUzqbtO85ys_XoDw_hrcwJ01OtKr7D5Kez38_YWWqZcJG0g1w6
 e2u3I9uuj9UUAgZdn83vJJc_9MQCkZ81TjRR869p_YspHNDqrdt4_fNOFjF43aO75DzTkr0D.7PV
 TGaV.7FE4UOekkTuW7sLBi3rgMN58.v_5BBalKAWup7OE1rMwshNShtPEbbuMNyldcqwpGlVdCVt
 rLvGuVeBonO1_5nsKoamwVO9JklVPUOlzBn7gVNUVNj3ilFqqHhH0LRFKojW_pAD0xwk8ODse_xj
 CcezyhgAvn8.Jw0rNlWQ5WqPIgN0m9O4_gsMMY2iJusKwJMES.dFpd88Bsyw4iH_Vh7NQcIZvG.d
 Bq4Be22Tr.fGJ56qPwXR8K.qghyqMjBLW8968vXGEgfs3tRJ2pe_z0qr.biY6Mr7WK5EAwhZ_HsU
 2WfYeazC6x5XEnd0nq_E0.k77F21roYnh3.b279mdf3WVcqA2eNDxPXMwa06ejG1RCr.WStFY47E
 amH5roreARfD1SOVyqTh_ifw_68yA27IH1ARAE6OgjXDnlX_wiGvvzfb6beVtrmUa_oqFEKotOth
 YIUBEeRjM41Q2D10WtzvSEuY2aTdvFrQaWJ9rF72Q0Se8PpaD_5hvJscjFeemc_3PdkTQ55nprFt
 W2h1ShGLzvZESNkJaW4.0oFQ_I2KMrkzKSN2lKBLnfkmibuUHyjKKsV5.PdrpKbaSUqL5hMPSlfc
 u1F_Y2B0SWe7Plp71q9F3WSLKBCw4vZYjLKPpeATuo.MYJwCZlfXQ68pqgVi45nYPBIxnHMKuRSq
 oHwS9mGCsgZefLYixw6hqE3ndDm72DXv8UgXyvii_Le2yz12kBgRPm90ywE9JP.h0CYKjD6Fv851
 yFpZRPrCiGLowNTYYC6edExnv2gKkHQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 7 Dec 2020 18:48:55 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d44ea59901fdfd830ef88befde40b9be;
          Mon, 07 Dec 2020 18:48:50 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] init: remove root_device_name
Date:   Mon,  7 Dec 2020 13:48:35 -0500
Message-Id: <20201207184835.63538-3-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207184835.63538-1-alex_y_xu@yahoo.ca>
References: <20201207184835.63538-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root_device_name has gone through many iterations, but is now solely
used for removing a /dev/ prefix off root= parameter. It's time for it
to be removed.

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 init/do_mounts.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a2a273b9866f..544614279281 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -29,7 +29,6 @@
 #include "do_mounts.h"
 
 int root_mountflags = MS_RDONLY | MS_SILENT;
-static char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 static int root_wait;
 
@@ -449,7 +448,7 @@ void __init mount_block_root(char *name, int flags)
 		 * and give them a list of the available devices
 		 */
 		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
-				root_device_name, b, err);
+				saved_root_name, b, err);
 		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
 
 		printk_all_partitions();
@@ -602,10 +601,7 @@ void __init prepare_namespace(void)
 	md_run_setup();
 
 	if (saved_root_name[0]) {
-		root_device_name = saved_root_name;
-		ROOT_DEV = name_to_dev_t(root_device_name);
-		if (strncmp(root_device_name, "/dev/", 5) == 0)
-			root_device_name += 5;
+		ROOT_DEV = name_to_dev_t(saved_root_name);
 	}
 
 	if (initrd_load())
-- 
2.29.2

