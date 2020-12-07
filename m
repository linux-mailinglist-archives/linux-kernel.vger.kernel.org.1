Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80DF2D18BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLGSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:50:03 -0500
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:42830
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgLGSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1607366927; bh=fGb//aWaDozXNHBiMFB8NfP+v8ZlSJ4ahg8Af9n5T+Y=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=kq6cLgVzFt0zzkKeH+quArpl1JpGx66LEFjGjPVZVVzvSheBqPaRXXJXGaomDj+MPdrH9QlgsaXP+sJ1NMc863+fCLbJ+oGcBuZGNB5sIp5wB/fo1ybXUh1JaqF36BtkfHJaW4OUwgjG+JVsOHOfD5DTVXMK02nMaLGMyoljiqhtjrSzJ3s5SEDbyZjZUp2GP1zg3gOq72E6+Tythko0B8ZiJid0esKriRbAnRbHsmuTqmfgOWww8sUWc3mmLb7NcF+eehk86gC2uqU+qZogIgjStj4O3xus06rrh/JcPcc3Ot5qBmA27CC5ccNETEw+jsmPzpFudqvpqOW5pTTVDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607366927; bh=rDUJRrOTryfosZfjk+F8MzAJi/f/SqJvhQN2h8KGmmW=; h=From:To:Subject:Date:From:Subject; b=Ei7FMw8GBbiz+i1wzB6hFvEC9tqIIFtrjgwYbgFJrWuONAIzIHVEubyiKviV51D4KxQwkve+Uhy+iDJYjTtPAhaNbwSGycAuxYvoYdYsx7qj/PILceFCm3sKkyK+4MwJld+vTZBAUyoKDQHjDpgHgW4bp+N7A0VG/4Pjlc5YLD2aFEXeWoiuQPI9bc217KHoHVYwEjaWjNRC2zOc7xteFp6mXvXsgVJL40YlW3CCN/4AxKuOVZjXowZ9lVQaiwpd/2rS0ig8aYGxkrt1kbmz2fNrjQCBNxmbQB6jyvyrEsHTrmacqZ6hwNxUe0xBvMvUyTtUqMYcKu2fplaT304cjg==
X-YMail-OSG: 8J692doVM1kADPq4GTASYF5zxCmoyKBKLGi53uJ1YsJ261QEa_363XID6t7FGc4
 2gcMhaALio3ovvZ2k9LOQ1R8eXB16Js0O3R8sqeCsHE7wZPFVgjOj0qgYQ1NseO0EWpk1VK2HZjb
 zKv5StXwourjXox__DbqFUkYb77DKUpIrROc602AcEnkdLZsXNTeJiXKRgQUXx3CmhKWkU93eIg4
 CVjVTKmCMHzp0Mfwvh2cmvFByP0W8ZujwYk8SjTcDXGuNfWtewDkVHhAEwNO85nsFBg_vZ.Xq6KG
 s6lnXDTIAXcPKlTYPZxmWLh4IdgjttLdgwm4YxnJ0PE6y.6dY4My1BZVmRvsGFEEN8x.G.tH63u2
 tdJhKwfmb8wmFgFAT3HzXPV69yTYPrUAijRJxqYQClVL3H7nJwFyzHSGMI0qlUkSXV.kjqSpn_Z2
 1xvWcCmziLDVb0ylZOMV5Lupkm6DP_ZmGDwtisG9H4MurghwZboEJe.jQrKQYnwfvHjzniB4oJuJ
 gCypuXvPfk6C_5HQ6M.qTDVhC2B8MwyQGYOOfO9JjFuzqYug7xch5Kmlkci7m_tVL40rIQ8kO8lr
 Zc7FuCDY_Mfzsh44Me8bncI8Zl1kxaCKW6zQf897zYdlgxsoLXfT6z9M8QF32L1GDjjhBsweWnHA
 up3vk10QLLNJw.HzGBDHng1yT64frDbanUAovQPt0AgiC6x9UyJzjO65j1BkmjFYzSGMCEIUXx8V
 VSD94vsAiJ04aNlgUNkOOSPtLFfj_O1KgW7JmRHEKCZbxdNBR7h3nfOgBHyYpr9pNvW8YPDKvMnJ
 UGvS7u1D2yiSPb2oGkR6RUFjAyb3EUiuMbMreSKMQNUU1QjvoEQ8eIUd5zKRdN974.1ywzyn.sSh
 1lNY.spe25dHJHSjg2JmOO.u_ydzvwV7PN3n319BUFaySv8JG_jBdXoiSKPypbyz1yZfLn7IBzcU
 C.hM.uNhiFPSFFAI7V3NJeSnKjSgfOqvwnLiXcxaogmXuEFVolJYpcXZZBCNXjWhLci_dArMM0dj
 Bw3dhMhw_VEvX3X3rvYwfQ8xnMXlHnh5L29UTJaQXYh6P8IARA8AeILvujki6XcHYrPl8_58jWUy
 aJkRNjIQL.3X_3iTbCubqWwMV8B5qrspd5FoE6TVj86srzz21nDZzA.D5DcAvEQ8ygPB55PDmltZ
 vt9TzZbmqT.vm9JXSNUAlL21.Dpes_aa7yZy9yhbdVdrJA60WnqtHhrelovzNGFyH2JVozQBJ6s6
 ujyOKu.qK3EUTtG0pxtpP4HJCOLkAhTZ2TYP7SRdPuo2ByErDC_zgGL4OtApheUOAWciYjwvoHfb
 NhQI9vEkK3B8inaHTVqZnPGZNweF8P1xbqD.9kuHKWoB6uJXST4w1pq3rY1.pRYM6fi_Xpgf.Sg_
 ywSvCsKyp0kWACBS.A0kEz7vT1SrQifJfzWcshB61xVYcfVSANnx3B10uNvLL8EDU6s.Zie35FyI
 K.fPyHGimjugWIWbPfS4vTDU.b1hyARjEWR1.YigDO17PAPHkMWIyk5jIQ7D0_9UWoKmK.D71vZ_
 P6nRyxa.Z4oArVQ0RaC_zMhJI3WlMCJHd_M2DD2he37BHaug._amw2.T7X0CM9y45WfVDzNbHmk0
 4ozVKxyMvnwczwqkQ6ZODkCIdYvuVIs.mtxzEu7S812u4tzhpeY.fMkn53k6CUDLXr5NVc6.mosj
 lKwv4b9zO_wmR3aELCiODsPikxqm29Rn3uhPz475dmH7qdobVln0PT6VEycJ4U1O3ONUEba3Y6N.
 BSmpN4BkCFV_zmzNvbzFPnJC.DDGo.JLMpf.k5gXGqCGdLUqy5qqTzlVaWonouTp5299r7sXQimH
 4I6SGSrpyGokCSClNlBDGIkGfvznU8yyBTxLGdj9MUxHGCZZAyJr9qkMk4zWhEB3y_6QtlVpZlkf
 OcuItW3oG1MpR8OJl9110QDWy6TKepo4whsIFIA_j91IwTPiads9lVpq05GBdbu5HDvkMy412IFf
 GeMlV_S7ixjzEPnF5z0GkicuPErV4hfwzPEGrI.UAq0DWF4x8YhOFTfkp4qHL_o0fSf_ppe9CA4K
 AAMs04wDao6xGDHStH4Thh06W.xQttCU76nM5jT7_N.1hZ80og5Yd5AV5seAfD4rqRuoObo8uGCR
 0sJj.iaCm1NDYQwH5aFL_ISdt4QfWw7BAkMHcgB28ZrOfa0X2HrBxnDISTAC2XclWn2mitKaaxLL
 dU7kbWGvOd5rHU2y1ygyRuu5VXZeOYDpcBQSOS9L.P60EHSCcnEr7MlfID9C2eSvoFQ2ULCyIXRC
 u13XWcTHpmD.eymMbPBdKxe05j4m7oii4gg9L81GeiPoczTM87qYyydOXz2wSUT4pzYffHLs3AjK
 6BFj0jt7JyZARcu_Dx0zO2..Fl_77oHfkIbf_jQNWiL6N7a.AXbY0tkg4GrLCxpt_V7WdAeKHt62
 XVqtwnX4GmzzF3MmIQXrAlEqugwrKknFTkaAvd1XxK1NLnMAWTQzpkoeTQAT.YdWGrx1ZTSM4zPY
 w_wM3WAaQZjADxGoE9ES1TFB9mIyXEegOWQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 7 Dec 2020 18:48:47 +0000
Received: by smtp421.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 15c1ba362414b2e2a9fcee793f9069fb;
          Mon, 07 Dec 2020 18:48:43 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] init: remove special-case for mtd/ubi
Date:   Mon,  7 Dec 2020 13:48:34 -0500
Message-Id: <20201207184835.63538-2-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207184835.63538-1-alex_y_xu@yahoo.ca>
References: <20201207184835.63538-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be handled by the fallback after trying to resolve it.

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 init/do_mounts.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 8aa38ec0bfec..a2a273b9866f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -603,11 +603,6 @@ void __init prepare_namespace(void)
 
 	if (saved_root_name[0]) {
 		root_device_name = saved_root_name;
-		if (!strncmp(root_device_name, "mtd", 3) ||
-		    !strncmp(root_device_name, "ubi", 3)) {
-			mount_block_root(root_device_name, root_mountflags);
-			goto out;
-		}
 		ROOT_DEV = name_to_dev_t(root_device_name);
 		if (strncmp(root_device_name, "/dev/", 5) == 0)
 			root_device_name += 5;
-- 
2.29.2

