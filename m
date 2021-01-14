Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2415B2F5B66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbhANHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:36:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E20C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l23so2729982pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w8R51QsrEKDLwADFp2JX2ohNQRA7wXsnzFQpBQunQhU=;
        b=cZqclifFJtPeQhDZPhpEEJ67qPONAeZqsxzJ7IEigeCotI3xy/DfkkfjLL4jx8N8VP
         Z9UmvIyKDymt2SFDMo5QUdqkpUUTIUatXKwOR9eZeWdhk8/lCcLtCH/9IZM0sO0VSB4O
         H126G7x1Xsdj2jO4fTSzf7ux3/bsU8PnvV5QrCRT4focInfezml69jwo1vPrciruoyog
         iexyJYD2ZQ52IDf+K7JxDc6qLy8kkmQ/TplNKfi5fd+jPYiLY2urWvzMDDsTGegvKpda
         SLwtxO15rr188Be3QZo2oSkBjPtD1SRekfFurLlSIeXXmz892bqBF/vJcYkq+6iRakwc
         NvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w8R51QsrEKDLwADFp2JX2ohNQRA7wXsnzFQpBQunQhU=;
        b=RhH37eoZ17GNb9ykjKBTIy5hI7NAbuK6bxQhsB+Eh7zKQIxz+QHPYihwiDXa2a60JT
         leP2H60JezWEwD4nWzlRKSYKdeej4GWiK3MsVZYWFwKN/DXQwV0k8nUAk03KyWU4RL0O
         LWz1FMU26Bj6VnyiQppv+oqCwKEFv4V0UxT7CLtUNggVRHLU1l2AUObpgvUcC1kVdT0J
         nssGQga8574PVtBgW+xf409/QbpCmvJLcvkgXjlc8AnZwUpShBP0L6ZKMY8ZbMv1kNNO
         rdPzZOjwiWVr7KLZ7yew44zboxFYnIY357WLglD9NhPPHGds2wADCmBnLHS34AftspMj
         muPw==
X-Gm-Message-State: AOAM533Uh3/2FRaEedQc/pC6WuKNYEdWbr8wqB4fvtR0v6h2sgrJLRrn
        Aj/lthU4liipB5rNN7vanZU=
X-Google-Smtp-Source: ABdhPJzsLz0g/qR3luGSVxu7dmwLn48wdBRdEtAk6zNvG1HXh/Br0U0lCD5PArX3xGq2z9Y678Me/Q==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr3671543pjb.93.1610609723619;
        Wed, 13 Jan 2021 23:35:23 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:b1fd:acc0:2bb9:df96])
        by smtp.googlemail.com with ESMTPSA id x20sm4442145pfc.3.2021.01.13.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:35:23 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE and provide fix
Date:   Thu, 14 Jan 2021 13:05:11 +0530
Message-Id: <20210114073513.15773-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <84492ae9-7452-d296-49ab-4d37eed3b968@gmail.com>
References: <84492ae9-7452-d296-49ab-4d37eed3b968@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch gives COMMIT_LOG_LONG_LINE warning even for URL
lines, which should be avoided.

An evaluation over v5.6..v5.8 found that out of 1703 warnings reported
by this class, 161 are due to the line containg URLs. Out of these 161,
53 are due to lines where URL is the first non-whitespace character of
the line.

Fix this false positive by suggesting to prefix the URL with "Link:".
Also provide the fix option to the user.

* Applies perfectly on next-20210108

Changes in v2:
- Fix coding style ('} else {')
- Make the URL check follow RFC 3986 style
- Give warning only if the URL is first non-whitespace of the line
- Set $commit_log_long_line only for else case
- Fix the warning count with exact figures and according to first non-space char as URL

Changes in v3:
- Provide fix option for the warning
- Update the warning count with v5.6..v5.8
- Update regex with /^\s*[a-z][\w\.\+\-]*:\/\/\S+/i (earlier:  /^\s*\b[a-z][\w\.\+\-]*:\/\/\S+/i)

Aditya Srivastava (2):
  checkpatch: fix false positive for COMMIT_LOG_LONG_LINE with URLs
  checkpatch: add fix option for COMMIT_LOG_LONG_LINE with URLs

 scripts/checkpatch.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.17.1

