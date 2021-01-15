Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1872F7D27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbhAONvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbhAONva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:51:30 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B8AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:50:44 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h19so5959613qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M0hImjaHQEijsGWFNVRSK58OPmzXegMGybAGXkorBYA=;
        b=L8pUKUat+ykI1uF8TQkXwGTb372ZhTqzuwmI22/ms/eFbL6Veam8Yh+HxwJhh2WHsg
         qom7xmkOWITkpDPZn7fYzaO68cpMdRanw6nzjepTb4GTqyVY7j/NSz06nyrxMWsnu66Y
         lvy00VUerFk1PFcl3GQUJg7zYGvhbN2L2i8HwEaXk9JsbYEMeYgEq1/JJV3HKbBS4E5m
         bbgcQOwRNGa2DdTeuiuoZ6pjMCFF8TtXWM9mHJh0mt2GiK8e/Et3nO7jsfI172t3gG64
         +rREZPiJUw73ghiDy4YIPGd3fg7Ej0loEV4U//C/WirCixNKC1vLFm3tcS8DfBHu5WYd
         mC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M0hImjaHQEijsGWFNVRSK58OPmzXegMGybAGXkorBYA=;
        b=FMpfBxjECLNdFGjHiDfYhvaVo5RX6+7gFcFS3vUxVoKPt9hODQ6l31ztTuxDa8o5Eq
         pcNLn/061ObCF630k9oMTQffoka4DlRqFX+YWETpTrA8K4jsZfvt/XusqLXVjFzm3FI/
         rYmzof3jxnA0+R3M1KaRqK1htghKWAElYOchU2rUtVlP3p51UjYPd4FwP6borRzhfgW5
         g0Ow+7el17Qo3f7QhkKjk9YIMUP8K6O7hK8ahVGhTABCkUauzOkN2z8ABBnQc1o3tXqc
         z6IQxSJwo75TMZWYSmfHJMUWc2nbShqGqXY+7twstwh9MetCUHgZf3Qb6xGkFXh3e4Ml
         Q7BQ==
X-Gm-Message-State: AOAM532t707y8X9OI9RkaYjqcLAsOFRM/6TI+WYDQL6gGvrcqjPflUjE
        PZIqUu4TogPee7S++uK3auO+fmcU2OQFFFmqNMkWZQ==
X-Google-Smtp-Source: ABdhPJyHVgQc+sLr+sh1R85C4nrGmTF0iEFW34InRE2rGnVLzZOEKq9fHY5RoR8uCKdMc5Bxfriyq0nog38Afe1ug9w=
X-Received: by 2002:aed:2827:: with SMTP id r36mr11704933qtd.337.1610718643246;
 Fri, 15 Jan 2021 05:50:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ee881505b8e27cf2@google.com> <e2f7ee95-1681-3ae5-861e-fa3d7ac12f5a@intel.com>
In-Reply-To: <e2f7ee95-1681-3ae5-861e-fa3d7ac12f5a@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Jan 2021 14:50:31 +0100
Message-ID: <CACT4Y+YsSxY=sWHWAahXHj86HbBJ39pPfQqwS3-b1VfFOGz01A@mail.gmail.com>
Subject: Re: general protection fault in xsk_recvmsg
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Cc:     syzbot <syzbot+b974d32294d1dffbea36@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 1:50 PM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.co=
m> wrote:
>
> #syz fix: xsk: Validate socket state in xsk_recvmsg, prior touching
> socket members

-most

This got unrecoverably corrupted with line wraps by email client.
As my client does the same, there is a special hack that allows to
send a least a little bit longer titles w/o line wrapping: syz fix
alone on one line and whole title on the next line:

#syz fix:
xsk: Validate socket state in xsk_recvmsg, prior touching socket members
