Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A332E1CE110
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgEKRCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbgEKRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:01:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC84C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:01:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so11926139wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmdp25EQ8v0wuV4mVsq8FtF479Pr9MswXZ7O+Ch3s28=;
        b=TI0vssJBeyHfKkJPorkVHrlz52YVSU/E3UCjFd1m7lHuGT9QoQxtjyQHUvUx+32lTT
         TnayIuEewWH83ETvE+6HjPyKmVyxw/Qwp5496syBzsn6odOUhJCJnwoPNHt+BETnL609
         j7t7wkPLHZuVBPt7wW97H5IYwYRUHdfcjEHeUUuZsGUfbhX4AhKuxe20tcFxhyjI3HP1
         zu+Ndnby7fEYTZXWlgWQMxijIu/5Z2ylO17tYVaxpm0NuhpNL7fpCKy9TTfA2JdDWc+A
         Z8tkX7UbTIAO5fFHJqGGWjVktr5cs/hmE4qtNS8eXVf1O4ycgeQ+3Oq7dJMqGXkgNOB+
         2hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmdp25EQ8v0wuV4mVsq8FtF479Pr9MswXZ7O+Ch3s28=;
        b=DeczmP4AjORcEk5ZTLn1vWEXjfWhNVE7T7GPZEvjHn0JSsigCDOwngf5tDh4aChso6
         nUatW6ujD2YP1wc0LURxjDMgwisk+dahLk9lnZMshmtD4kz8bexT0fX0ComEtNXPo6ki
         FcDSSESM8GGhY60F66vLdqe/o5iHAacrtnLpWAEcRZi9tGLZWpSNWOENBvoPz9gGnEc7
         RKV9HqSZRfYJpclXz0xEwU+rH+rl/DT3pLIzDryR9VOgl+lER+WETdhhrgvzNLlMOudH
         ADYWgRB+sL8W+RycmwhXI6jUWpXTUMfSwAMESHTzeSGB0F8ju3EWgAOnwAyMb7vAmiGM
         H8oQ==
X-Gm-Message-State: AGi0PuYoIQ5qP1TE6EXZ2ZTAz3av3kEi97KGw9aI5zQgbDJ2OfjYcsvN
        9Gwgost/d43B/AeKVBLswbngfA==
X-Google-Smtp-Source: APiQypJMAkUzfIFHSDDRuJ6ZptTUoB8Twc6PWnX1oRT4RX4dM5kexeDaRf54TEZ2T9NcIEm0IZstAA==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr21486249wro.25.1589216513994;
        Mon, 11 May 2020 10:01:53 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id p23sm21670792wmj.37.2020.05.11.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 10:01:53 -0700 (PDT)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH v2 4/5] efi/x86: Remove extra headroom for setup block
Date:   Mon, 11 May 2020 18:01:49 +0100
Message-Id: <20200511170149.1363260-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200303221205.4048668-5-nivedita@alum.mit.edu>
References: <20200303221205.4048668-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch has been causing issues for me since switching to GCC 10.1:

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  HOSTCC  arch/x86/boot/tools/build
/usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: error: linker defined: multiple definition of '_end'
/usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: /tmp/ccEkW0jM.o: previous definition here
collect2: error: ld returned 1 exit status
make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
make: *** [arch/x86/Makefile:303: bzImage] Error 2

Cheers

Mike
