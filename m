Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5469B293148
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbgJSWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:34:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60221 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbgJSWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:34:30 -0400
X-Greylist: delayed 71429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 18:34:29 EDT
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E15BD806B5;
        Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1603146867;
        bh=Agves5U+ubCgP0FKT8aF6/zpHp5isWfipr7MJkw6vH8=;
        h=From:To:Cc:Subject:Date;
        b=TcGONhUUeLkgY4dM9KJc1he5tvNRoNUQoBTyAJTbzn1quDrNMGTSAokzMANRyUlGs
         jqViivxMnsjRhJsCRora0+NDbidqzHiyu/Km53hosurZf+99XTYoGTs+MxYB3Enart
         BrBEhaZJ6TsVEyeiXmwe1C1Dn4wTy+SUK31TbHhd9E/UapwVA5MXqKQuwMLbszSLE2
         I70/aBLm1I8en94/lHiRevBDJcq4VfxH0hfrwM+sbmydNuU/PW79w3/DfyKZKXZ2dg
         92QpH7YCF32g4mFmzKLOa7rGhkOvl2HfgLAtMPkDLQ9GXOaxyGsolavCwkwa3pg+Lq
         XHcNXQomj/y6w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f8e14730000>; Tue, 20 Oct 2020 11:34:27 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 79E6713EEBB;
        Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A8013283A9C; Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net,
        Tobi Wulff <tobi.wulff@alliedtelesis.co.nz>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] hwmon: (adt7470) driver updates
Date:   Tue, 20 Oct 2020 11:34:21 +1300
Message-Id: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the adt7470 driver to add error handling by using reg=
map.

Chris Packham (2):
  hwmon: (adt7470) Create functions for updating readings and limits
  hwmon: (adt7470) Convert to regmap

 drivers/hwmon/adt7470.c | 538 +++++++++++++++++++++++++++-------------
 1 file changed, 366 insertions(+), 172 deletions(-)

--=20
2.28.0

