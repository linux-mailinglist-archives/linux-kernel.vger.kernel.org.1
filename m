Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09B826D913
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIQKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:31:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903CC06174A;
        Thu, 17 Sep 2020 03:31:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b17so1016391pji.1;
        Thu, 17 Sep 2020 03:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k+2enWfqqILy+Gnd8aFpkqmOPrS/xqIZRf0Vu1kx8I=;
        b=KQjJtWEthOOxcaw9SMIUlIZ/VkAJBJC51v/p8FxRobm/5NQa77ipjtwAOmF6/MKPZe
         XvKWc+3uBGqgPKYoimI2ciBXp/HxYocK/E+M3IWgHybm+LIt6W7ITrIHxsRwfYsqpDBy
         /kcLvxF/OW9V0TdcVB+SkBpzIFikA1r8fDsM5/uXneSzQ9a+ecyryqme2bp1s5mTRcpl
         HjuwfZ3SXfrXU9cajfWQ+Rmlu+niMCnBIRS7JRz4nMhoEyd95AWqheIATRSG9G/wGE4i
         NA8DgOfj9Mv/FJ6tAwrp9uN90C/rC6r44zxBMjjmfwuuDQrIp1s+7E7mgiGpUTLkEOIM
         fjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k+2enWfqqILy+Gnd8aFpkqmOPrS/xqIZRf0Vu1kx8I=;
        b=o2dk91vIqOH0K1GvZTl7WVJM4/thHJSuDnrIpuadsj3lQn1WDRm4fVEHkAitChBUXi
         LpXUnoukERArmMWgl6oLTNJu/EylUTge7zAk5HFcJF1hjPDJf/YRcxKTB0PqTI6fJK0a
         UwODGAzpyA+OnTcV3AfZTTj9cSpbwy6cWbLOIHQ28CpOmfqi0zX5j9DT4zSHJFKF4AXn
         eiKYLlSjsb0QEAu1JKzPJ8s07253c7toWjIa6ATtZPzry8r5EFNjADiThbtGccQ/GmRe
         CWIHStbOnE7OWU1lNUQEDu4J3AHZlA8P/IRfakZEkabuOcvmKnWYBQ1e9k18OUOzRX+o
         /a+w==
X-Gm-Message-State: AOAM531fCDtNoiy1e740cU/G4ccXvgNuPWblr1ldlrCh+x267B/bCbKX
        fsfqJrHb5dzu/TimDx4tzLk=
X-Google-Smtp-Source: ABdhPJxpn0f9nC0LsqN8CNdcZjbCyswhe+eUHU1FfjjrzXGmYIVMt3OTervUn+W31q+bJQfAPQjdNw==
X-Received: by 2002:a17:90a:be05:: with SMTP id a5mr7886030pjs.120.1600338710501;
        Thu, 17 Sep 2020 03:31:50 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e207sm21781927pfh.171.2020.09.17.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:31:49 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v4 0/4] docs: fb: Removed framebuffer scrollback related documentations
Date:   Thu, 17 Sep 2020 15:56:11 +0530
Message-Id: <cover.1600333774.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In this patch series, documentation get in sync with the code removal
of scrollback,by this commit 50145474f6ef ("fbcon: remove soft scrollback code"),
by eliminating the information related to it.


Changes since V3:

Remove the wrong commit hash and messages from all the 4 patches i.e 
Commit 973c096f6a85(vgacon: remove software scrollback support)
from the patches as suggested by Willy and Greg.

Patch 1: Remove the documentation related to framebuffer scrollback from the file
   fbcon.rst

Patch 2: Remove the documentation  boot option for scrollback from the file matroxfb.rst

Patch 3: Remove the documentation scrollback option from sstfb.rst file.

Patch 4: Remove the documentation scrollback option from vesafb.rst file. 

Bhaskar Chowdhury (4):
  Remove framebuffer scrollback boot option
  Remove matroxfb scrollback boot option
  Remove sstfb scrollback boot option
  Remove vesafb scrollback boot option

 Documentation/fb/fbcon.rst    | 21 +++++++--------------
 Documentation/fb/matroxfb.rst |  2 --
 Documentation/fb/sstfb.rst    |  3 ---
 Documentation/fb/vesafb.rst   |  2 --
 4 files changed, 7 insertions(+), 21 deletions(-)

-- 
2.28.0

