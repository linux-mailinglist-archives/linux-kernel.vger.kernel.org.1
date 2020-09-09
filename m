Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E226267C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 06:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIIEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 00:52:53 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:38044 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgIIEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:52:53 -0400
Date:   Wed, 09 Sep 2020 04:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599627171;
        bh=tNg5tAtet1Dlg5OTVR2V6g98ZiGX3ACoiac7ICl2DmM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RJjpCFBlvf4fdppzE0wIZMdw7YRwkSpBxEBlQNj5ME/vGCIWrGlpYpRnJCiP/PGiU
         +udrl/F8dvHP3cUkPeWpT3Lr8gQI7A5WCK+dQMcFMsd2FEBwthAIi1DBRzxqdvn/6H
         YXrWzzaEZpKZSowKgunyCfo4+AZqRpXOPQWAIpqE=
To:     syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
From:   Harley <hl1998@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Harley <hl1998@protonmail.com>
Subject: Re: KASAN: use-after-free Read in delete_partition
Message-ID: <XjoJ_0FjJeoD1mcx0kiX8d7mdvChRUfhcnMXFMbWHmo9OQQiNaaIOn3puoADsae1WvNuBnoLgGrpczV8lDoCW7tqtIjJBqMHECHkDPX5n2w=@protonmail.com>
In-Reply-To: <0000000000009323e705ae870d48@google.com>
References: <0000000000009323e705ae870d48@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am having difficulty actually reproducing the bug from the supplied C rep=
ro and .config. Perhaps it is some sort of race condition?
