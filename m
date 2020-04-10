Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC221A46B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDJN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 09:29:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42112 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:28:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id j20so1101964otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=5zxEAuEDjXmiW8+ZquBj+33DwvOSKS3hGPuZSFQhDJo=;
        b=u6Xg/b7Gk6GNT21oeypp96PVJXKe7Y7qwoUZaZe3lpqyonFsary/ncqzlgQ0F0WI7Z
         JQk5KPzImBN0fhBU3IRy0auBD3c+E7qtpykSf6een3+auN1JAAefp6tIhFkafUneYEVw
         h/aJQ9gw3iWV8j8WNaq8Bi8elpgAmC1tEm7i7Anq9F4942Q3Fc/LWr2N9UBQhE/d3Ej3
         epny4pPOIl3yLrEz/2gnZM5Myj7gzEeG62kiHyQ+3zn24oWPe/pcAozYr2dJTelBRD4D
         N+vF9+Imn/9bC9bmR/ZOm7sZ2ZyNcvFydSNvZ/+LwxQn0HwMjkmYo3f2nrRYuFuSRwcJ
         0FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=5zxEAuEDjXmiW8+ZquBj+33DwvOSKS3hGPuZSFQhDJo=;
        b=iEtZGyaghwAjtUIcC0ilGFLNxw7dX5wwhe59NfaLgTCfA6BgDltBaqSDgK39p2eEKM
         lP61eMvos1AsdCRT/5Qidt0EDiyKQkICyxTAi0ueK0kVOIhC+9TrDAuG3CE5ikVNSrpa
         eNaC4W5FXhnV5xP/WE3Lvep5aZHyeCynGcI/w55cPmL+egZ+35EDLlsRWlCSQ98rcnNU
         RO4G7SVfdLth2fB5vO6SamCbq/WpKKQ/zJK9XWcfqTqUK7Pvcttxh5kcAPSJ6yi0EUVU
         3iUfxgcOv1OZuiMg406P+ro5v5OaKZ4o9b8+Rycrk3Aoh87Se1TTmGZ8ZpsiLPFxy/+r
         +Y7w==
X-Gm-Message-State: AGi0PuYG9yTrTvvN+x6mwvBXoXDp0pYgPHN/EtxTfMjqLuH7/eFyHb0n
        LwM1/8Rq2DdVltMrSkZhC7hXdZiVmQ==
X-Google-Smtp-Source: APiQypLYReQTsloNqceBDNCD3C11NGH3akgDvz2gDKkdD9PD0ISozvqGB/a4okViZKLbCc3qtjem5Q==
X-Received: by 2002:a05:6830:19d8:: with SMTP id p24mr4210363otp.309.1586525339486;
        Fri, 10 Apr 2020 06:28:59 -0700 (PDT)
Received: from serve.minyard.net ([47.184.130.101])
        by smtp.gmail.com with ESMTPSA id f45sm1193341otf.30.2020.04.10.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 06:28:58 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id C35F7180053;
        Fri, 10 Apr 2020 13:28:57 +0000 (UTC)
Date:   Fri, 10 Apr 2020 08:28:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: SUBJECT: [GIT PULL] IPMI bug fixes for 5.7
Message-ID: <20200410132856.GI6130@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cc6e2c599cdca573a8f347aea5da4c855ff5a78:

  Merge tag 'for-linus-5.6-2' of git://github.com/cminyard/linux-ipmi (2020-03-12 09:59:36 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.7-1

for you to fetch changes up to e96387677c2a4a35a0c8b16cd517696a04050062:

  ipmi: kcs: Fix aspeed_kcs_probe_of_v1() (2020-04-07 08:35:40 -0500)

----------------------------------------------------------------
Bug fixes for main IPMI driver, kcs updates

A couple of bug fixes for the main IPMI driver, one functional and two
annotations.

The kcs driver has some significant updates that have been pending for a
while, but I forgot to include in next until a week ago.  But this code
is only used by the people who are sending it to me, really, so it's not
a big deal.  I did want it to sit in next for at least a week, and it did
result in a fix.

----------------------------------------------------------------
Amol Grover (1):
      drivers: char: ipmi: ipmi_msghandler: Pass lockdep expression to RCU lists

Andrew Jeffery (3):
      dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
      ipmi: kcs: Finish configuring ASPEED KCS device before enable
      ipmi: kcs: aspeed: Implement v2 bindings

Dan Carpenter (1):
      ipmi: kcs: Fix aspeed_kcs_probe_of_v1()

Jules Irenge (1):
      ipmi: Add missing annotation for ipmi_ssif_lock_cond() and ipmi_ssif_unlock_cond()

Wen Yang (1):
      ipmi: fix hung processes in __get_guid()

 .../devicetree/bindings/ipmi/aspeed-kcs-bmc.txt    |  20 ++-
 drivers/char/ipmi/ipmi_msghandler.c                |  18 ++-
 drivers/char/ipmi/ipmi_ssif.c                      |   2 +
 drivers/char/ipmi/kcs_bmc_aspeed.c                 | 151 +++++++++++++++++----
 4 files changed, 153 insertions(+), 38 deletions(-)

