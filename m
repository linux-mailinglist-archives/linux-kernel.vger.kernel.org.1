Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC312C1A34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKXAtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgKXAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:49:12 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:11 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q206so21829373oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hul6Z0rO+u1oGC6czmCmGCiWhnk2qL4GQew7Mv6jjWY=;
        b=rQbtH5oCDK+DnHuvlkGyEzdzQoEldmvcvQG84XE5xUyPYhcMxGZB3WZTShoBbYf/hD
         5kltV0Nc4TPH3WCg7OY31ssZ+UdKyexTEDTOP2RRbmwbUtVGtDAa649GOZK3xum72OPe
         9jSaokQM0MWqeWAeeGOw6zCQERTh9b98a7PQmL3ZDuDMo9b1nMiq1/rNtMGo8D4tXm0O
         pwGaBSfNS4EcpYk/sHUx4H+RSWlhUEik/Z3yYCGgEVStLbhbxWh8eLL0UMhqq972pr9S
         u8j5CyDeTk9AMwJNI3PLkElM5zHq1qSODZfeM0JNt2zX/Fnd7qUDQpqgwR6ZziT3wMCe
         bxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Hul6Z0rO+u1oGC6czmCmGCiWhnk2qL4GQew7Mv6jjWY=;
        b=DsGIjm+LVl5zeab0hDZnVOwc4N/mF1T+DWLbY5x79aNz732SDGGVL1MBK0Q+yl2say
         NeM7vSVug+RkDHJmg9sav0eEMMMi12JOKuv0Y6ReO3NyGtD8F1d9ltfT0CHpKZ4Jp7XU
         I1cQs2gOKoB4W+GVjRjIG6FGUF7UDkHjQo/boH7avnCOGiynUkvI2V4kvP9NvPGdOamS
         9rtjBl3C5hKuhxBcPsA4PSDoiqD+g7osk24VFRkd0LZQNxQFwWBE3DamGdiAx1gqEmf3
         a6waW+axWpyUr3nGdrfSmdikz0eWM/SDX3PyxHYubsROlph4iRuY40i6BK3Kk69oLxSW
         N3kw==
X-Gm-Message-State: AOAM533iczlVQXK/WD6+jpYL1F1RmtAjJPvgbUDcq9o+eoMfbRGPHlNK
        5FtiED+HPtk3vn9+UegXiw==
X-Google-Smtp-Source: ABdhPJzWaDoI2j6bYN3hgdz4WIRnEIOuutBveimMn1frGDF4RjNeuCWlcpPq/cM6y9/Wt1VY60NYeg==
X-Received: by 2002:aca:1c0f:: with SMTP id c15mr1190080oic.54.1606178950981;
        Mon, 23 Nov 2020 16:49:10 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id c130sm4100312oia.33.2020.11.23.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:49:09 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:413d:60da:9340:6f51])
        by serve.minyard.net (Postfix) with ESMTPA id D62A2180048;
        Tue, 24 Nov 2020 00:49:08 +0000 (UTC)
From:   minyard@acm.org
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com
Subject: [PATCH 0/2] drivers:tty:pty: Fix a race causing data loss on close
Date:   Mon, 23 Nov 2020 18:49:00 -0600
Message-Id: <20201124004902.1398477-1-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got some time to spend with this issue, and I think I have a
good fix.  Not really a v2, this is a completely different fix.
Basically, calling tty_vhangup() on the slave when closing a pty master
is just a bad idea.

From what I can tell, the tty_vhangup() is there in case there was a
console redirect to the pty slave.  When you close the master, you need
to release the redirect.  I didn't see another reason for tty_vhangup().
So this has two parts, export the release of the tty redirect release
for the pty code to use, and call it from the pty code.

With this change, everything seems to work ok and no data is lost on the
slave side if the master closes with outstanding data.  I have updated
my test program to check that all written data is read, it's available
at https://sourceforge.net/projects/ser2net/files/tmp/testpty.c/download

But, this code is quite intricate and I certainly may have missed
something.

-corey


