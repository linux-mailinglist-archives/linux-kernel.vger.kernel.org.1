Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28C419DE61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgDCTJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:09:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgDCTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:09:58 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jKRhR-0002rX-6z; Fri, 03 Apr 2020 21:09:53 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9FA9C103A01; Fri,  3 Apr 2020 21:09:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on "uaccess: Add strict non-pagefault kernel-space read function"
In-Reply-To: <87lfncl76i.fsf@nanos.tec.linutronix.de>
References: <20200403133533.GA3424@infradead.org> <87lfncl76i.fsf@nanos.tec.linutronix.de>
Date:   Fri, 03 Apr 2020 21:09:52 +0200
Message-ID: <87imigl727.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Christoph Hellwig <hch@infradead.org> writes:
>> I just stumbled over your above commit, and it really confuses me.
>
> Where is that commit?

Nevermind.
