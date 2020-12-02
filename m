Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080DB2CB5D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgLBHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgLBHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:39:39 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:38:58 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cm17so2235289edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKdADEqwydslKTzHGNwGQV8lLo1ySomcXHjqlFmG2DY=;
        b=wUqsbvPcVi1G+6MVvky3mFyBt1H1xg7mM4UpB+7mTkFs3dRs/gx2wO+b8L5YtHutC4
         M4tq7nfflddUKfvNP5yhEZDfPaRwk6OJyiieNvSIm+9mnulYYnOkuOA8TiX446zYpEdD
         /D0l1gox8lzW1MTcfXzvUCxVNt+7AzGh97ty4CKONrWaqgWOMFzOuwmGW4ph+JhDy6YU
         55I1606NSb7JfCFH0VDPuMTGjVG2PqcfStOaeLVvrQbI5eLZ/pZ1Lif+GG9kQ5RlFOww
         bxLMG+qdWcnkoWX0tEOoRZa7sG6ZiHw99obsYrp5tOHPTYVKDAoQ8aRFILg+mxhihWkD
         oFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jKdADEqwydslKTzHGNwGQV8lLo1ySomcXHjqlFmG2DY=;
        b=S4JgCUGcMBe28kysDIqUquAGOlBfDuymE7MX7yH+0rQ1TOYz8iFzk2JuOWSFVt4fXA
         jL3ATEtwsa50uQSTYJbg6k5AH5+i5uT+XyTwN4DV5iQ9GpM0EhogD3GLSX9UalJzqYMB
         LlSyWzQGyk3UWmjssCrhnbsOBYHCR3Pmw+oZWVEOJ5S5i9b4oxu7vsSjadVlV6noCYe+
         GqGvOOo5/WIKil4DfyEeXHjbpTHTfJEFezWOy6pI4vYTmfvrReKICzfyFyVjc0eNfk8C
         knaYEJTXs9s63y6A3qM2UPU7nlT/5f4oL4t3/CA+hLqV8H9gwKvDD0D3wl3a7hut+8Tv
         TbEQ==
X-Gm-Message-State: AOAM532EIAQbGPt6Fic3DPb5WfFZA51u6gYpLjhIuR+1m2IemIFgKpSL
        ilZRTjcrjQ1JILBJmYIDvxtNjLLa3raKC2rf
X-Google-Smtp-Source: ABdhPJzjpcNgDFGodzduymgm5WTghtDQejh7HLtYRzEEJEhFu+lRdgeXBTsb7Q67pkfTRy5S1KlclA==
X-Received: by 2002:a50:8f64:: with SMTP id 91mr1399523edy.310.1606894737324;
        Tue, 01 Dec 2020 23:38:57 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a12sm526607edu.89.2020.12.01.23.38.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 23:38:56 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] firmware: xilinx: Clean up series
Date:   Wed,  2 Dec 2020 08:38:47 +0100
Message-Id: <cover.1606894725.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for being able to review new changes more effectively it is good to get rid
of existing kernel-doc and checkpatch violations.
That's why this small clean up series.

Based on
https://lore.kernel.org/r/e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com

Thanks,
Michal

Changes in v2:
- keep variable name and type on the same line - reported by Joe Perches

Michal Simek (3):
  firmware: xilinx: Remove additional newline
  firmware: xilinx: Add a blank line after function declaration
  firmware: xilinx: Properly align function parameter

 include/linux/firmware/xlnx-zynqmp.h | 43 ++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.29.2

