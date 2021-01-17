Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6682F91B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbhAQKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbhAQKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:10:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B4C061757;
        Sun, 17 Jan 2021 02:09:46 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id g12so19544987ejf.8;
        Sun, 17 Jan 2021 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hbj4TiqfNR6KDmo9x+Wcu6q4y9Z+xI8CFkeUBvrKO4=;
        b=fac3OOSf6M0NyiQDLCWshRRv2i7d56V+bY2Ey1lzXfme2LjjI9DAEAPgg17yDUoHzO
         mLPS0qaAgpSYLETxdCHz1STukIe8tXak7zrDP67OkBSmHbQJ/eSQD8mvVKNJ7HEbBhQY
         Bu8bJE4nzEr/79rfOtSYUUHSP20xYfBqs7lDk6Ye7CIUiJE4mgScMfR69a7+MUFILQVP
         4hqiIacC10pWLVM5Kw1SHluw4Zzb6KaMzKvRlJTKtCit5JOtYO20+OSw78CfcJw7YDXz
         /mMCVMDjPk9IVrij9hmQU/gLdp6IqADvbDbN0EfY/eYkwQ/Yvg+xtcQN6qL8FC0R5+vy
         6Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hbj4TiqfNR6KDmo9x+Wcu6q4y9Z+xI8CFkeUBvrKO4=;
        b=Ssueu1PjGJaKHcyoyGmtlQx0DVQVNFoux58XwFuxJsNcfRrPJoFnCSdoyWgUx18PRa
         wBsz4dQGLYKwigsbj8LoQGkJa7TXMVin5q6ZVVTln6O86OrceQ9wbd6pgv7w1g4Ui5Ou
         Hj4g/ocHiH7tv1JKk+k1q8ba+jVmubhjhpp0lV/tuH6mtb8KDGIQFnogvOXQW76ZdPDP
         fqD3NJjvbR8ya2luDdKYGJAp1cUv3n/1H3a5kiaJUSiirxD6ZF76OHAtPLeeMKeK9Dhd
         E35/qgpejvrruLZEC/dIqQSOPSjZ+YWfT42xPEXsiwqMMznDxZ6jcroeEufghnIm44+2
         NBuQ==
X-Gm-Message-State: AOAM5316HL2Fqcljp/WlXFYqs22rE6yUlHenVfpMw5CDheVvZNF3cOd4
        +Z9sl2hzO+BtyLvraP9/KVMrGDlZTGxR6w==
X-Google-Smtp-Source: ABdhPJy7kufNgD1hQhhnL3ejsZMF4hwBNC25V0OSF6EGSbMwIu9vYZd9y2UnVgk6lT7QnEXJ5IroqA==
X-Received: by 2002:a17:906:2898:: with SMTP id o24mr13994283ejd.215.1610878185339;
        Sun, 17 Jan 2021 02:09:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:c06a:642a:2af4:1e16])
        by smtp.gmail.com with ESMTPSA id s19sm9277855edx.7.2021.01.17.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 02:09:44 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     SeongJae Park <sjpark@amazon.de>, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] docs/kokr: make reporting-bugs.rst obsolete
Date:   Sun, 17 Jan 2021 11:09:30 +0100
Message-Id: <20210117100931.9347-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210117100931.9347-1-sj38.park@gmail.com>
References: <20210117100931.9347-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Translate this commit to Korean:

    da514157c4f0 ("docs: make reporting-bugs.rst obsolete")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 0a42ffdea918..787f1e85f8a0 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -345,7 +345,7 @@ https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버
 
     https://bugzilla.kernel.org/page.cgi?id=faq.html
 
-메인 커널 소스 디렉토리에 있는 :ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
+메인 커널 소스 디렉토리에 있는 'Documentation/admin-guide/reporting-issues.rst'
 파일은 커널 버그라고 생각되는 것을 보고하는 방법에 관한 좋은 템플릿이며 문제를
 추적하기 위해서 커널 개발자들이 필요로 하는 정보가 무엇들인지를 상세히 설명하고
 있다.
-- 
2.17.1

