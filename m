Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697662453B6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgHOWEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgHOVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:01 -0400
Received: from mail-il1-x147.google.com (mail-il1-x147.google.com [IPv6:2607:f8b0:4864:20::147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807EC0F26F3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:01 -0700 (PDT)
Received: by mail-il1-x147.google.com with SMTP id z1so8884280ilz.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=oxh1zcQhSSj1sRDYKLj8pdLk064Zf9K9zDx2kCQjG6E=;
        b=TqJTrQT0/Cn0rhjCFO1z0Ug2NRF9zak/8e/cs68WFxEVtwMmn5Qaek5jQDam+f1HpX
         DXjdtbFCTmnMCzdiAz7bNCdmgRI0+c5pzElUiyStxk05I1fYBX7W/jBo6SBM36rUf6X4
         whBpPvg4b9QoTuLezg5xZD+ZY7mf7QWa2UvXQzBSNtKoWrzbhxa5loWnEMHMP05pwk+2
         HvaRohuE7PHj9685m9SC2GySXJ/wObZwTmLH3oUgJJ/BFdrd66DsEfTGpgHlhNgq5p5A
         OJZfGK/zZIQTnPI1y8oq6MLHEDczl775N5NlDT4cmM1zqHMTZ7KMNuRntd0ohd/Jd4Ic
         haFA==
X-Gm-Message-State: AOAM532eI7GbbHgE2Y13xrWRebV1RporoOYJVxRuWiPbb/rEr0P5elew
        j25gFoG4R+ItfnDJbMszOLsxwGANdxj2XTICo7uUkl4sFFPl
X-Google-Smtp-Source: ABdhPJwKIeEtMwp1Y8DbX5t31FAG0vSEIhEefpQF/pyBQ5lBtW1+CfErzIxRKUS8nmtkvSnig51XIfvJAMACW2/7etVGb8cI+Crj
MIME-Version: 1.0
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr6289294iop.93.1597515300962;
 Sat, 15 Aug 2020 11:15:00 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:15:00 -0700
In-Reply-To: <e3494c53-f84e-5152-42b0-f8ddd3ad4ccb@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009878b05acee84c0@google.com>
Subject: Re: Re: possible deadlock in io_poll_double_wake
From:   syzbot <syzbot+0d56cfeec64f045baffc@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz dupe general protection fault in io_poll_double_wake

unknown command "dupe"

>
> -- 
> Jens Axboe
>
