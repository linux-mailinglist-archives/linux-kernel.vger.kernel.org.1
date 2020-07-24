Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F122C5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGXNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:06:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E6BC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:06:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a8so6996216edy.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3vTAXp5UNkHqzq3GZfUbTi5Z+R09zUNcA0X3G2MrbI=;
        b=pXUS8mcImou3VSvYHnHnnxPJElIu3vJ9aR8WjzwlAEEMz+GgTGI+GvqBMt0ZEfNtiw
         N8GuEunExTszNiU+gCWliSrElwQLXPH80UwwqsefK1tPbWNgeg02u1jR5O08vxz6inq0
         76xZFuWdKTzpxvQYMbUOZwUD9WKXGGEdP0UWrgGi16eXBdZEW6krZjYU6HnMorwirzZB
         CO4/9P7KVnohsryfH2PzLPEQY5dOPkhhlI+Pqr7T+fEES2bWCx8J4/asWLe1VsY4xld/
         xY8A1or3lA2Qr2URXLX3/LC9FqWpGTSkuga8rSAdUYmFc3H+jhFeycGhDUb4UZEA19B+
         n0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=q3vTAXp5UNkHqzq3GZfUbTi5Z+R09zUNcA0X3G2MrbI=;
        b=IUwWWqyWKVUbptNuatXfCRauLPA46jFiotZ9X9mZZZsMVnpD9MHIz8Q44eSEAj8EgB
         8c7QuEdT29GE6k8gSoUDuqYwsZx0PevjbhGehgletGKkJ3290eRYZy5/wkhBeA7fSun3
         9W5jkJHsMoqE0jbomfuC4EKJGF+voejbegsbgDg3LF9D2t+WSIVEekjPkN8nsAheqKcN
         ktGhScdIJ1FYZSVS13hGp04nll7vev3X5vSMyaAuAiY1HlsToHuWTYgXXNdlK2Cy1rbi
         AwEWB9/RPy5K+n2tDQifN4TFzfWMlKG4VTlfXzYek130ZdEHABf0X0KUkWIOwM5gkEZB
         3WJQ==
X-Gm-Message-State: AOAM533AjDCZIPjc/bqC3XEZltZVztkezl6nMOld/IaigfPD48axmAqi
        C2XK78WXuRvi1k2QXKnrDorcVcKw
X-Google-Smtp-Source: ABdhPJyOSE9K0yDKCNmzIBEGfFcpia/YERb7AhZcI/crP7f6lOd50f5hzw+zx2SGqvCBXq7A0n2uKg==
X-Received: by 2002:aa7:c504:: with SMTP id o4mr8679223edq.311.1595596017608;
        Fri, 24 Jul 2020 06:06:57 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y7sm678201edq.25.2020.07.24.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:06:56 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 0/1] x86: Refresh the defconfig files
Date:   Fri, 24 Jul 2020 15:06:37 +0200
Message-Id: <20200724130638.645844-1-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a 'make savedefconfig' run to reduce file size & match entry order.

Ingo Molnar (1):
  x86/defconfigs: Refresh defconfig files

 arch/x86/configs/i386_defconfig   | 91 +++++++++++-------------------
 arch/x86/configs/x86_64_defconfig | 93 +++++++++++--------------------
 2 files changed, 62 insertions(+), 122 deletions(-)

-- 
2.25.1

