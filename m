Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC189263914
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIIWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:31:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D4C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 15:31:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so2044770pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtoAvOurFFZP/gUt2lOxm9is7YQr4gyUFJI+eCbp8z4=;
        b=nncUTurk+QTmh61R5oSwO5R5vYFaOtQwsoT1xsoDlKIM4Bisb51TEz43D09Ty9brUU
         EeE2JTcVrDeGt/IOKdBZAku5MwinwMy0rXaXhTuJrZNDBT5oNPlMwdlCn06bzjj7WdNW
         fc3JeZEvrCgrQTn8CjWa7r01EYq0SAsqNE8Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtoAvOurFFZP/gUt2lOxm9is7YQr4gyUFJI+eCbp8z4=;
        b=XTgyLuI171G4yfLgA5b3srXojWCpztd/wMVyCZnBtGmAFarXfeAnzy3ykccApPB+O3
         6VREEXGZyLumR+RMxj4XRn53pEPK46UQ23zKhsapvjqO+QBggXwnxQh0VEZYcavBbmV3
         NQWWQY8/Yg3IN3DPlyEiVY1Afv2BL7yNAXNM97kA53iwFEbcjnQ85IGYlY8QxdDgH+/o
         q8YookIuPKbG47COk0OQKi/gcI9EVzq1/MKgzUc6qfxuBb7Pnyknqt71zGzdlro/aQoe
         Qv2LE1UCHJlUgDhpqvYZbf/QL9N+wlYGR4zeHTWq7uyXUF2xlskOlgTcsACZ9BLQfJbX
         DEJA==
X-Gm-Message-State: AOAM5301n7WEL13QC4xhL7QY2UBvXwp2Od4zSMz0v9S7tHNFpIvSV0K4
        hmyH+hEDyE6G9PAhNIM+bnWrMw==
X-Google-Smtp-Source: ABdhPJyd/8VUFRrDN1AM3yMkWgUakcKJSafwNXibEDC+aIZz/Pj9EACZVIkCAEUcPwVPr9WZtbWqiQ==
X-Received: by 2002:a17:90b:a4b:: with SMTP id gw11mr2462960pjb.37.1599690717790;
        Wed, 09 Sep 2020 15:31:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9657:a5ff:feef:7b57])
        by smtp.gmail.com with ESMTPSA id u14sm3826433pfc.203.2020.09.09.15.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 15:31:57 -0700 (PDT)
From:   Sean O'Brien <seobrien@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean O'Brien <seobrien@chromium.org>
Subject: Re: [PATCH v3] HID: add vivaldi HID driver
Date:   Wed,  9 Sep 2020 15:31:48 -0700
Message-Id: <20200909223148.419843-1-seobrien@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <ad58952a64bdf8e64bf4da5461db43c6a30d3b70.camel@perches.com>
References: <ad58952a64bdf8e64bf4da5461db43c6a30d3b70.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> if ((parser->global.usage_page << 16) != HID_UP_GOOGLEVENDOR)
>	return;

I'm a bit worried about adding an early return, as it may cause issues
if someone doesn't notice when adding another case. Looking at this again
I can easily remove the second line break now that I've changed the group
name.
