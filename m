Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3722E271
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGZULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 16:11:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39991 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGZULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:11:05 -0400
Received: by mail-il1-f200.google.com with SMTP id z16so9975588ill.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dudMlHrGLdKPFIb0BzzoKkVe79aQGzC9+73fmHoxPl4=;
        b=B3ChkOMEblNaef603gDj8Zbh39bMr7FDSbzUwgiwAQJHbR3pQPdekjSCVKqR7juhBU
         +fEdmKafgbjD4O/fyNxOCXi+46+3KgCvDeeh7UsK74yNqZJqoU5w6NX57B9IfBjfZSB6
         ze3r+Grr+laspji6wrecjv1xxzSma00jVVAYGHDRYivomCGRYH4/SBTL3XDf4yTXXCU4
         7kKh+w5xkLQSQMZblivXeS6od6S7m0WHbsPdF2FVFSqS2FS3fpg245e+BuKdh30W7FXo
         YdMorvLvr2HmCE/HTYJEA5zBbFYBGhD4E/hv/8lcsJEnkuQ4ZN58a/W4q6pFh605Pl+v
         wlQQ==
X-Gm-Message-State: AOAM5301IcyhzVs7r+VoB5DXv4pt5V4gvsknRGLrFi/pmKtf19JsWzZC
        DDnijzoCmfAjTqqu5tpVpyY+igi8fRi4U5ytdE7w5OgfnMtd
X-Google-Smtp-Source: ABdhPJxlhsn+KetcpoEYX6E8Sqw4cArXJbnl+vGX1w1VtK02FAsTySNjK8rKWmrP7TpfzXn4wYZbP8u14pwiNS94yoEOKeUVblSa
MIME-Version: 1.0
X-Received: by 2002:a92:4983:: with SMTP id k3mr20209144ilg.56.1595794264312;
 Sun, 26 Jul 2020 13:11:04 -0700 (PDT)
Date:   Sun, 26 Jul 2020 13:11:04 -0700
In-Reply-To: <001a11405628bb07410565279f4a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004251b005ab5dce75@google.com>
Subject: Re: WARNING in xfrm_policy_insert
From:   syzbot <syzbot+5cfc132a76d844973259@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ed17b8d377eaf6b4a01d46942b4c647378a79bdd
Author: Xin Long <lucien.xin@gmail.com>
Date:   Mon May 25 05:53:37 2020 +0000

    xfrm: fix a warning in xfrm_policy_insert_list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1774b9df100000
start commit:   6c677750 mlxsw: spectrum: Use NL_SET_ERR_MSG_MOD
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82a189bf69e089b5
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfc132a76d844973259
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f8821d800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ec3c63800000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfrm: fix a warning in xfrm_policy_insert_list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
