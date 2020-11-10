Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1417D2ACAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgKJCBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:01:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42876 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:01:14 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kcIy8-0001sR-Hk
        for linux-kernel@vger.kernel.org; Tue, 10 Nov 2020 02:01:12 +0000
Received: by mail-pl1-f198.google.com with SMTP id t13so1965607plo.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 18:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK2xra2umGqFG+SzI89RLBjV289wxSEZaa8bAGmNZH8=;
        b=W9Tk1nTkMt8Tb985ObY7+yp8rbjLFWjkVScqs6oE+MRpUT1esPc05w7bsp7Ik2Neop
         gEkZd3In2hranew3jhGgmgf/3Vm/u1xBy5rpPc0A303cSnr2qjuH+UqirebA5TNUAv8v
         IzCBlAgcVMLbq4CGmbGmFptoZ9vwQLsxelG0ZE0MCtQfAJjwiCK7/2n4lhVDm0vP1aqC
         p5hhL516g2wG4ilfRDsnJzmtPmZ6WNYrgomx1/cx/LL32DHIcwxIQ/2LKLsPlXlpu3+T
         2veMArgPDVdAtvto0wxM2XG7fuD5wZlUgep41GttkjTuKiUH79gjblFk053Z/H9JHbNg
         rkeg==
X-Gm-Message-State: AOAM531pO6YeWhv/Ehc/6gOa1adW7WswXGc0j5gOIQmkLPKY0K2FC4Er
        Jcj2fN4ACfeM+q/C2/dHAwki8GWXpgTdeCZEhaAeN4zNK36vMnJFAWE6w49UGdY7ByE23WiA9Eg
        wyXZ1tL3M+W0AOYIscq8hF+gULB/04svn8HyoLuor
X-Received: by 2002:a63:4006:: with SMTP id n6mr14920446pga.171.1604973670944;
        Mon, 09 Nov 2020 18:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY3UB2LhbbRYn8No1bJ7jZB3fD3rnenjheE0iTW1dlEQcjHFmUi1r5RbodJAJDhdcKbtmrEg==
X-Received: by 2002:a63:4006:: with SMTP id n6mr14920420pga.171.1604973670597;
        Mon, 09 Nov 2020 18:01:10 -0800 (PST)
Received: from localhost.localdomain (223-136-189-104.emome-ip.hinet.net. [223.136.189.104])
        by smtp.gmail.com with ESMTPSA id c193sm11855552pfb.78.2020.11.09.18.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:01:09 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org
Cc:     davem@davemloft.net, skhan@linuxfoundation.org,
        po-hsu.lin@canonical.com
Subject: [PATCHv2 0/2] selftests: pmtu.sh: improve the test result processing
Date:   Tue, 10 Nov 2020 10:00:47 +0800
Message-Id: <20201110020049.6705-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmtu.sh test script treats all non-zero return code as a failure,
thus it will be marked as FAILED when some sub-test got skipped.

This patchset will:
  1. Use the kselftest framework skip code $ksft_skip to replace the
     hardcoded SKIP return code.
  2. Improve the result processing, the test will be marked as PASSED
     if nothing goes wrong and not all the tests were skipped.

Po-Hsu Lin (2):
  selftests: pmtu.sh: use $ksft_skip for skipped return code
  selftests: pmtu.sh: improve the test result processing

 tools/testing/selftests/net/pmtu.sh | 79 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 33 deletions(-)

-- 
2.7.4

