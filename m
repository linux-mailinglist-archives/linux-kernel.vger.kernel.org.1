Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9D2F0616
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAJIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:55:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05793C061786;
        Sun, 10 Jan 2021 00:54:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so10615492pgb.0;
        Sun, 10 Jan 2021 00:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liDHC2sc0cr7MOD3v6T+8shxUFheQf86Vm0SzTQ9WXM=;
        b=atwdkiH3rwhPEk6LsxtkfISVI2HnSv2gU7B+BrKOk2OPz9qvBr17fBbPjskvH5b9ML
         ndD0VqBzC84BfCEv2FWekqJAhlQsmBvvsYk3UMn5jPiQkA5W3kxj5xL46SWDMaA1HUhi
         Ln+IyZkd+l7+XIQVF6rVVw0+Xouoy/xfsUoYhyqsfhprOOZ/oux6iZndi/Cdw7r3IOzP
         OUDgcP8nqrZNeDY9iWTDkuOCgHzgtAzA4+lReIJYQwmHCyRnRo1wIkISVgDd0XO5rti/
         q03wbTpYOYM8fv/BnydCPGtCfXYGapvEiWy8l+WuKKzvya/jlLTXYkm59g2q9ceTBQrd
         mn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liDHC2sc0cr7MOD3v6T+8shxUFheQf86Vm0SzTQ9WXM=;
        b=jLXvXMez5XGQLWJXtAziyoZdQwNzn8ye8UmM0kro1tD2l9LbftWjv95YOwvURd1d2h
         Dw1hmwIMZPYnp/52wDVGblJ0JUswce/HZdNc0hkDFRL6dqq6yFm05okoprBBXsopTUFY
         7/4zv40M/xuSPHxqSk4/Kf5xhVvBgOzOkTc0xhSU57Oil4rFJnf8nYJDrWUibCID1GV6
         VXdJZhANseC/1Bfq6OlMhmVq8yvMqhIc0wDufwPGT891/arHE+ktHrwBc85hZtXY/nS2
         REpN0YyTXaZUIJ4zR22xO7qS4WTN6yprKekd4rpjdodtN29UyHeZHPtMnqMvVv19VD1a
         9pEg==
X-Gm-Message-State: AOAM531MClZKGx4CgdX9d2fcN9adefaYxSX1ukAac2Y9n0YuPDHgw5X9
        O6ldWIKHBvCJxodL/146eVY=
X-Google-Smtp-Source: ABdhPJxLY/kyPOVEREpU8vfsjTraNvHv+idPkcVTS+ovgVGV70f979+i+ELhOSStG/kkOCAuh0KUFA==
X-Received: by 2002:a63:db57:: with SMTP id x23mr14673530pgi.131.1610268886518;
        Sun, 10 Jan 2021 00:54:46 -0800 (PST)
Received: from android.asia-east2-a.c.savvy-summit-295307.internal (53.207.96.34.bc.googleusercontent.com. [34.96.207.53])
        by smtp.googlemail.com with ESMTPSA id u3sm12346904pjf.52.2021.01.10.00.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 00:54:45 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        minhquangbui99@gmail.com
Subject: Re: memory leak in mcba_usb_probe
Date:   Sun, 10 Jan 2021 08:54:35 +0000
Message-Id: <20210110085436.3616-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <000000000000f599c005b6f59913@google.com>
References: <000000000000f599c005b6f59913@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/minhbq-99/linux.git 080e743dff190ee8ebec63a13ac33fe8b7e4fc9e

