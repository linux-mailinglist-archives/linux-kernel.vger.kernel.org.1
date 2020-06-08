Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAB1F1B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgFHPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:01:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42366 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgFHPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:01:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id y11so19252268ljm.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exJpUcD9iTuoeD+RQrF+EIXmGMlhgaTXtJncvvlvAk0=;
        b=uGir2OpahHpWGpoS5PSjlkZF7HzYFUSaPJVrp0jn88LMmfKkVYjxvKbnOCfO8KoB+d
         ba+ymAr61Xum4HkmzpNz6CF5L83I9WNiZsqoEWKPe2Llo54/tMo4yJU3aLJNdDcRHF/W
         TPsagiqLWjVWmmbGXTyHAQaPAxJ3rIIU4e91Ozy4AvlajrDftywAYpLk3CTTo05GojVv
         O2+uImLDAd6S/BnE272YF6+GRuK1KLMIbJbdZ0DR5DFGz4cToZ7XikbDUD6r1NDS6TWm
         8mqn/y3QSfG2KWcYyQAy6WZezF8Y7xSwBr4rwAzeMDU46Fb5oAtRrXO5nfZwjUW6Gra+
         uQZw==
X-Gm-Message-State: AOAM530TEwzWYjeWIxIRJyNikQUeL/ATkVWQanMU0Lz1oYj5ThaMwlbm
        m1ZZhrYHcVuOilfLOYbgobXtLc2lFHE=
X-Google-Smtp-Source: ABdhPJyDFsvVJzzCo2+DwICPtXyXHTVNh5CKDd4tolo+GuOiJuRevDylwfPjtNkxuYiwEjHyeiUkXA==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr11002311ljj.214.1591628470929;
        Mon, 08 Jun 2020 08:01:10 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:01:10 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH v2 0/4] Update memdup_user.cocci
Date:   Mon,  8 Jun 2020 18:00:34 +0300
Message-Id: <20200608150038.223747-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GFP_USER to the allocation flags and handle vmemdup_user().
The third patch supresses memdup_user(), vmemdup_user() functions
detection. Last patch is a proof of concept for the rule selfchecking.
Gives the ability to detect that an open-coded pattern in a function
definition that we search for in the kernel sources changed.

Denis Efremov (4):
  coccinelle: api: extend memdup_user transformation with GFP_USER
  coccinelle: api: extend memdup_user rule with vmemdup_user()
  coccinelle: api: filter out memdup_user definitions
  coccinelle: api: add selfcheck for memdup_user rule

 scripts/coccinelle/api/memdup_user.cocci | 106 ++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

-- 
2.26.2

