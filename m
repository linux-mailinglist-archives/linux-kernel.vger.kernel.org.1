Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9E26A062
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIOIHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:07:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbgIOHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600156412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=61XyTnabdR3NqmCYghXPRu0a00uOW6F2LZTRRBnM3so=;
        b=CrlT+YOWJkHuLLgl7wqQ64ZPqfwsOLuH15bTdEuFYHz5xMukxSBuGjyBXstkM9Dru+00PD
        iL8Go8k/dS8l2HYOkyBmouhxY6ZTAkCVGq3dBLZdY9CMXck4Ug3hvEEN5jcKGAwFqPjRHU
        hsv6TOVV89QiwJpPnyUgFZbMAKSwCgQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-UVEn26AuOJ6ZglRQ48EI1A-1; Tue, 15 Sep 2020 03:53:30 -0400
X-MC-Unique: UVEn26AuOJ6ZglRQ48EI1A-1
Received: by mail-wr1-f71.google.com with SMTP id y3so887755wrl.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61XyTnabdR3NqmCYghXPRu0a00uOW6F2LZTRRBnM3so=;
        b=mGurItTiPdh8hXPKCR0BDyl8u3RT1l8Cyvw7hgauor6v9SqeJy5RZLvOFZ6OAXnfeT
         A05WYMiqWCnoh6E7L9lLShnMP1ZCqBnwzpyi3da6ts4Q3a1CcSZwDcWy+UfA5O+8WV9T
         3NoD1QY9t7W+vWXNyuspy+nW2YbbBuicg+jZ9lYshCNr8EvsM18rpPIi3c3r9A1r5vYO
         4jCaAvVmMv2xFy5MvIlwz972HOr1tymojXPpgTq+L0ZpgGuz+nK52bv6VcRiktf7037k
         opjVuoFv1s8e5UDL6Biwbz6Ibm8FrT4IFI6a4KVJB4zna7sNQCtGQJSUgyKkj+wCMfhH
         wOhg==
X-Gm-Message-State: AOAM530rhBEVkM/3XqUYfHde+xRg1AWLbcPHQo3t38h9kXDxriFJbOrv
        IhmIiV2SlEj9oueAo0z4c5mw0YCjg0Ro/yvKIwDtmehCki7qF89FEtq/pZpouVM+lbDdrypfd9b
        ALrBRh4svHp8Q7gmCX+RmZfD/
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3264076wmc.84.1600156409098;
        Tue, 15 Sep 2020 00:53:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkAV4ygJHEBfx/E27MJKpvpu9bhuqLwU6gUHpd0uLVhw1GCrwFd2UquUQYFkwwu+Z+57dJqQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3264064wmc.84.1600156408935;
        Tue, 15 Sep 2020 00:53:28 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id t16sm25301572wrm.57.2020.09.15.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:53:28 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 0/3] objtool: Miscellaneous cleanup/fixes
Date:   Tue, 15 Sep 2020 08:53:15 +0100
Message-Id: <20200915075318.7336-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches provide some simple cleanup or lift small limitations
found while working on the arm64 port.

They should apply on current tip/objtool/core branch

Cheers,

Julien

-->

Julien Thierry (3):
  objtool: check: Remove useless tests
  objtool: check: Ignore unreachable fake jumps
  objtool: check: Handle calling non-function symbols in other sections

 tools/objtool/check.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--
2.21.3

