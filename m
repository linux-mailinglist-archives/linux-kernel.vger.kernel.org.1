Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42E1269DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIOFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:14:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50206C06174A;
        Mon, 14 Sep 2020 22:14:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d19so716112pld.0;
        Mon, 14 Sep 2020 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/5kuvOFRsCKu+6nDd+XhcQ8QH7gMIC+xWf1Bx6Gd3o=;
        b=IX0DGyQ7OFUJIyCBSbfmfM/SAwUivNuuc4kN+x2q79ybS9jRr7MYuVS/lS9naqqvaf
         SlJp3JEjyuP1YpIaa73sHsweITXuadtdhcZgfyIfJDaNFh1S5kO4ZHoe5aCvYreiykD8
         gBbP1j8jGL+k+qyk6WKxiKtsfwFKNMmyCv02TOadLQg7lO2prr+bKulPCYh10jL51Dot
         8gaXWykVyWX8aC0BTBUHN5oNNL4e40nviC02QjwdGYyG9Dxnfy9+B1Y47YnrdyFQJrr6
         2eY1Nuxikk95AbE93grLp74Gr8jIwQIF0phAz1aCIpVgIAxHtmioUU/wvgXioF2L+ZJp
         eZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/5kuvOFRsCKu+6nDd+XhcQ8QH7gMIC+xWf1Bx6Gd3o=;
        b=DHtcc8A+k0m3jFCidNUj170RfvP2O5z6BIWuhAhmXWYAq5pKk0Z7vqCIghNtonxSu2
         Myw5lo7DXLcC2uYi7DlewuHw/YuPuDAcFYMWEJBJc5Tdl6Xks1CsiTcLaj1mdo161y3t
         +0Ia+TYRpKxMClyFbadLM/JW9yOrfnD3YtD+ArocLZXI/AruL/bBVwGXf/J434WhEMjS
         muKXSU/LUEDsgaAPeH1YVRID/R7CvZrCXrx2/qnC1pKPbV3Uolq3ZLGzikX/tZbCJHde
         gi2xnznsereuOVuKJQJuSqs37JemXqD8PUB3Tyr/NAfq/wqh9OhL2HopXVkj0+eig0Cb
         PYPg==
X-Gm-Message-State: AOAM533lQXfZ1He083B8pd3JtN0mxoE/nKFVoh9K8GpfcX+LVqlHSN9j
        pV1AR0pzm2+qZ/lzfegrFNI=
X-Google-Smtp-Source: ABdhPJw2k9ouETG94gpvrYqqLNZ+Hf94CajRc5OTryVrjxVL9Qyn6eFvaJR3NW1p8JAYN3D5hkRfLw==
X-Received: by 2002:a17:90b:815:: with SMTP id bk21mr2582897pjb.57.1600146888887;
        Mon, 14 Sep 2020 22:14:48 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id co3sm5400187pjb.31.2020.09.14.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:14:48 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs : fb : vesafb.rst : Removed scrollback related lines
Date:   Tue, 15 Sep 2020 10:42:19 +0530
Message-Id: <20200915051219.19479-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed the scrollback related lines from this file : vesafb.rst

In the effect of this commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489
and 973c096f6a85e5b5f2a295126ba6928d9a6afd45
 

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/fb/vesafb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index 6821c87b7893..f890a4f5623b 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -135,8 +135,6 @@ ypan	  enable display panning using the VESA protected mode
 
                 * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
-		* You'll get scrollback (the Shift-PgUp thing),
-		  the video memory can be used as scrollback buffer
 
           kontra:
 
-- 
2.26.2

