Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B58265E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgIKLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 07:09:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgIKLJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:09:36 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599822574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8e0pxxJH5bvqyXUdopdnv8AU4NOZ57q17g5LHfGiIso=;
        b=PmoT/NKR5J+QZW3chjgEAiazA+YZT1uZoXpNdQMpK+tUuRQRi7Whn5uDd6TtPSIOm7kUFp
        qT3pmZ70iJlk2j98WGDddvx/drcT9V0CIdMkBaFFKBBeZMDio2ZjJgSo8tDjo/fx5iehiV
        e0QxfNmKn/etEBwTcz+h8D2UvBrx8Sm/JpQJTdarTpI7MeK2LPcc8qMGGk5PphnDp8IGPf
        NI49WHftA55SgYOpqX41D77ED1kmyeYnZNbSDEjPm8jVPxC4KZUJ9jzchtdISKllCOCa+n
        eUgbdL5bFCsN9FOTIohQdU5hSnxKgdd2uTns1/hlvl8A/Ibc45js25xg1+sOwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599822574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8e0pxxJH5bvqyXUdopdnv8AU4NOZ57q17g5LHfGiIso=;
        b=/YEAk75iTR8jQRR56YOmOrMjR/3yO/egbhcj52o5rptNvt2kBdhZ08vl+m3RYerHsfYONt
        6KxUMrGhfW240DCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [POC] printk: Convert dict ring into array
In-Reply-To: <20200911103217.GJ3864@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com> <20200904082438.20707-1-changki.kim@samsung.com> <874kod6fgh.fsf@jogness.linutronix.de> <20200904124530.GB20558@alley> <20200911095035.GI3864@alley> <20200911103217.GJ3864@alley>
Date:   Fri, 11 Sep 2020 13:15:33 +0206
Message-ID: <878sdgefiq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11, Petr Mladek <pmladek@suse.com> wrote:
> I would like to go this way in the long term because it looks like the
> most easy and reliable solution.

This change is technically trivial and I don't have any problems with
it. Actually it follows the agreement made at the meeting in Lisbon [0]
of "support for printk dictionaries will be discontinued".

So there will be no more dictionaries, but subsystem and device
information will continue to exist as extended record data.

John Ogness

[0] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
