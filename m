Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49532ADDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgKJSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1716C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:01 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i7so10913124pgh.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsrVlmyAtM1K+YkC9o0RIUvZtd2QIppgyNOZFO0Pbxg=;
        b=MZ1ms1731XAw0nxOXdKHrEXbxCiBjvpX+st8Mz+ugd4EPKziIxosIlwbsMDhryhCvu
         WO2IHnc8R/iIU90v0upu8+1g/MZOp0ZmeeTegY/dHe2zmDpjbPRlkDQ2ocxL8HflxNi3
         r08Mwd2FZgJagd3q1nQhZoGuniSWQHTTNzMKFb5FUe/il4IHEOD3/BI7+fKv/Ffv+JaR
         wXLKvm7vNmFrg/WRtXeEGJk62AjjKx9z149JQ2SOwTIih8UB4AJhIidkgXD7GmqnzX8L
         AmpAmK+HEc9JISWjM9gJNXsNwpU2Ps7XuVj1nnPacw1wObdfYSUK4azNRltq8YTTKMif
         jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsrVlmyAtM1K+YkC9o0RIUvZtd2QIppgyNOZFO0Pbxg=;
        b=VKq+69YObFNrFXeUrvPlpiK7Kwm/USmwczvkvzKzh3lLybbaQPChgDj/FylcbLJp43
         tb9WVnbJAiZg5U+L5VyLshuU5u5Le6HDRRaj5ZUqz6oo/P2hcEfOjn6iF1Pmg8/1beb2
         D0HePQu7juwqE7HlS6F15bvLz2XMMeul61TRTTUcpLriipJm0KjEzvGleIeQL8BN4lxp
         1BSpa87fB4FmuO+HEj9nq6uH6sYVIcDaE+IIFqspb8FZtLJYUQkaPFLulbO+VWVYJCok
         1cGUuN+3XFlmSasOzCWE4Bk1ZzTXxJhYgE1I4Ym8jCcSxOEM7IpS0kzxDFnzke0+zu08
         mRKg==
X-Gm-Message-State: AOAM533bBHUG0MUg89+SYBE1izAY6J6ciZ5gI51m/vfbGGio0DeBaeZm
        26pdk2NaNsyWVveKAdIwhwU=
X-Google-Smtp-Source: ABdhPJyPz4ZLmHXW7yjRFNkJShAhlzhuMtYXBxPadY395bUKIhkO1mzb6AHb4ubfpGCRrUKTpRsHUA==
X-Received: by 2002:a17:90a:5e4d:: with SMTP id u13mr338745pji.171.1605031981234;
        Tue, 10 Nov 2020 10:13:01 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:00 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 0/5] mm: misc migrate cleanup and improvement
Date:   Tue, 10 Nov 2020 10:12:45 -0800
Message-Id: <20201110181250.264394-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some misc migrate code cleanup and improvement.

v2: * Fixed the comments from Zi Yan
    * Collected Reviewed-by


Yang Shi (5):
      mm: truncate_complete_page is not existed anymore
      mm: migrate: simplify the logic for handling permanent failure
      mm: migrate: skip shared exec THP for NUMA balancing
      mm: migrate: clean up migrate_prep{_local}
      mm: migrate: return -ENOSYS if THP migration is unsupported

 include/linux/migrate.h |   4 +--
 mm/mempolicy.c          |   8 ++---
 mm/migrate.c            | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 mm/vmscan.c             |   2 +-
 4 files changed, 108 insertions(+), 64 deletions(-)

