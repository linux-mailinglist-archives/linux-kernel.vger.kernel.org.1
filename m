Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4982905B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408046AbgJPNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:07:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34191 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395548AbgJPNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:07:03 -0400
Received: by mail-io1-f71.google.com with SMTP id y70so1525768iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=TmagrjaTaq3E2DP8JBZt6KyjUmMR0mGK1LxVmFcWSSU=;
        b=sgamiQlIu5m9jDb7FxilQ+mLjk3/NJ4DRCbwbNmKSOBpRtj82mTKEsQXAZs5fwUJTw
         rrfJfO+CPQwvIXudX02sxDsgDn0IRuTsRU4Hp2e8MKcxNYIzsD8U2XbpwcdEgjW0n41U
         AY72pZ2XxYkaEp/IjXoP8T3XfgPRONd2Xa3LUL8u+znywRkGeE5va3oSvhrhzJP1xkZB
         TKs+9T97fHb0huFijHc9NjwCj/Bkzok9Y5h+ISCJEmn254RjlFEMWeKgBjqov5/YMlBX
         vrh9OzBq1tKsEIkbo67M8UD6af9qR2KEmrwwNHI7M9JptZLmOBYO8ZzKqu7YD94ZdLCV
         efqg==
X-Gm-Message-State: AOAM532FiUkScyzu2wAkrugkpHv05guPHCy8MpgpfUNA4YWShSOcfLJm
        TVTNBfNU3Se+uelpoGSvAyOU6JpebrPC7z60ZPf8rVI9/eA0
X-Google-Smtp-Source: ABdhPJzsE1HndCkevEstV3GvbP9OM+n/6AG+pcQOj+x/ph47yPOeywoJ50rWYofYHmPEpn/nvgXz0XgsiyqiLIpn0lvP26N3b+t2
MIME-Version: 1.0
X-Received: by 2002:a92:180b:: with SMTP id 11mr2548773ily.89.1602853621294;
 Fri, 16 Oct 2020 06:07:01 -0700 (PDT)
Date:   Fri, 16 Oct 2020 06:07:01 -0700
In-Reply-To: <1399790.1602853614@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9732805b1c970f5@google.com>
Subject: Re: Re: general protection fault in strncasecmp
From:   syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git 	f25a7033ecb675101f8bc060a7c5fbe0c9076fd3

"\tf25a7033ecb675101f8bc060a7c5fbe0c9076fd3" does not look like a valid git branch or commit.

>
