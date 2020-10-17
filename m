Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B33291194
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 13:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437355AbgJQLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 07:13:34 -0400
Received: from smtp1.kaist.ac.kr ([143.248.5.228]:53263 "EHLO
        smtp1.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437174AbgJQLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 07:13:34 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 07:13:33 EDT
Received: from unknown (HELO mail1.kaist.ac.kr) (143.248.5.247)
        by 143.248.5.228 with ESMTP; 17 Oct 2020 20:06:50 +0900
X-Original-SENDERIP: 143.248.5.247
X-Original-MAILFROM: dae.r.jeong@kaist.ac.kr
X-Original-RCPTTO: linux-kernel@vger.kernel.org
Received: from kaist.ac.kr (143.248.133.220)
        by kaist.ac.kr with ESMTP imoxion SensMail SmtpServer 7.0
        id <595760cb0b67440a9c04038fe1fdce40> from <dae.r.jeong@kaist.ac.kr>;
        Sat, 17 Oct 2020 20:06:51 +0900
Date:   Sat, 17 Oct 2020 20:06:51 +0900
From:   "Dae R. Jeong" <dae.r.jeong@kaist.ac.kr>
To:     song@kernel.org
Cc:     yjkwon@kaist.ac.kr, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: WARNING in md_ioctl
Message-ID: <20201017110651.GA1602260@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I looked into the warning "WARNING in md_ioctl" found by Syzkaller.
(https://syzkaller.appspot.com/bug?id=fbf9eaea2e65bfcabb4e2750c3ab0892867edea1)
I suspect that it is caused by a race between two concurrenct ioctl()s as belows.

CPU1 (md_ioctl())                          CPU2 (md_ioctl())
------                                     ------
set_bit(MD_CLOSING, &mddev->flags);
did_set_md_closing = true;
                                           WARN_ON_ONCE(test_bit(MD_CLOSING, &mddev->flags));

if(did_set_md_closing)
    clear_bit(MD_CLOSING, &mddev->flags);

If the above is correct, this warning is introduced
in the commit 065e519e("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop").
Could you please take a look into this?

Best regards,
Dae R. Jeong


