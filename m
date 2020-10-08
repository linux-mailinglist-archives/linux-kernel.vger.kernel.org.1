Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61F287392
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJHLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:51:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9400FC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 04:51:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ce10so7677102ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=EKS4Rl7taEFKEAjyfKeNM4So5LpeFxU2RUXgnXem7BU=;
        b=Q74/FCsNrM4/oj1pPejy/g9GINBxGZsA4gVxVIaYJ4MsGEVX1y+Xry2faiiplEiEQz
         gp6YTOpNWHL6yM3gV6tFeEjdhFVav7Ac+ZGcIHUHKDvN8cv3DqAW2Bo8nV5cgVxCTaa4
         1dp/kgPM0/ltWe8+0HIxmxsW02JpnlePwBkphxenlZ5e2dVb/FqLS0a+nkMAnRvAJhr6
         YjXVPrglDxwsFXIyCwsC2c8c5l5ABjK56GtUB7N3QLPsxLYTtL2Rln3xoR5c916+WrzG
         1bvUGfkBoQcpvlY/K4LRUXOlEae+jxMl4vk9Vzav3mDY8Zse0T7SzeDKJTbUaxyy7Jpb
         Di9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=EKS4Rl7taEFKEAjyfKeNM4So5LpeFxU2RUXgnXem7BU=;
        b=FeT/LI7QAjP3B2JeC4EPXTDz/M2Z8mjchN4gHt0yckIPlsDgVhwao5ISDD8tXRS0Aj
         OUICBXpQ7ztQjdQ5U7JkF9HomPiK5gh3g391rgIalzP6Xe7tqqv6yd5QW6y5OsFPat/J
         DJqQxXLTpOH/wg7UZcSt9I9YmGAbbK1EQJa/5nLao7EqrquoG/rYJbDnWnBz/Ar4VHXs
         qlqXUBL5+HndSSUI47hF2DIokIxBPn6D8sTMspzNtZpvq6KG7tHusjp52mF3/c4hi3Wg
         TJH+lNhBFDE+eFGVAZ/b29IIugVuRNy9Z7A/Ipym9EpxqBaURpDNjn3FzJtjImgh0Sk2
         Duvw==
X-Gm-Message-State: AOAM531epOeDkNMRBCvY7hwHa+NHGhKMzifZgzSHPyV8vf+wB2STooHR
        eL6whgel5Gr5rUMyTWvV0bg=
X-Google-Smtp-Source: ABdhPJyEcyf9UBhEyTeCnS0LcUO9nqMkIqRZoXKo4/0oyvreo3Ih8ruMp3tAltm7LRrVFLaAFV0u8g==
X-Received: by 2002:a17:907:20e7:: with SMTP id rh7mr8673675ejb.515.1602157875013;
        Thu, 08 Oct 2020 04:51:15 -0700 (PDT)
Received: from felia ([2001:16b8:2dc7:4d00:248e:daaa:460c:6b4])
        by smtp.gmail.com with ESMTPSA id u26sm3732317eds.2.2020.10.08.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 04:51:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 8 Oct 2020 13:50:56 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: checkpatch.pl: REPEATED_WORD: massive false positive in
 MAINTAINERS
Message-ID: <alpine.DEB.2.21.2010081247510.19461@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joe, dear Dwaipayan,

while maintaining MAINTAINERS, I noticed that the REPEATED_WORD check, 
which in general is a great addition to checkpatch.pl, generates a massive
number of warnings due to one specific pattern in the MAINTAINERS file:

$ ./scripts/checkpatch.pl --show-types -f MAINTAINERS

results in 625 warnings of the following kind:

WARNING:REPEATED_WORD: Possible repeated word: 'git'
#XYZ: FILE: MAINTAINERS:XYZ:
+T:	git git://...

That pattern above is of course intentional and perfectly fine, so now the 
REPEATED_WORD check should not complain here.


Joe, would you accept a suitable refinement of the REPEATED_WORD check 
that address the issue above?

Dwaipayan, is that another good issue for you to look into and improve?
There are multiple ways to handle it either directly checking for that 
pattern or excluding MAINTAINERS or both or something completely 
different.


Lukas
