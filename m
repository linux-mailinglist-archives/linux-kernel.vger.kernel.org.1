Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206525F84E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgIGKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:31:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgIGKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:30:49 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599474646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c11Pcz7aCb6wFsJS6HKBIQCuoYxNBcPP716dGjA76nY=;
        b=z2COPvCUpsK3kvdLxwDCzaHGAV6+JExRlBiW+FQH7dZ+WWVOb2oD+bAfP9bu7ht1lTCjIz
        WcsuIaHJJ4nMwP/bliXjrZDAiynU6aQgYC9nY6SZB2EGdT/ViFOeLP0R3n80jFa1MldfBM
        OH8cF7BTe0NczS24k8b9TGq/sJVfphI91BLV72E+JjlD52ij1JqR5wnTrtBha4qYzJleWM
        A83WRSlKC0B2uNfrN9wqFua5e7EDFUSsWFHk41NwhnSOwk0PFiQoxzFgMlonPS/KWEN06p
        bmWLUXFmENB6J6umAbPNVvQUUcgG4Tle+DVA/J1k/+jHaPsaD2IyF3LKoT/h9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599474646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c11Pcz7aCb6wFsJS6HKBIQCuoYxNBcPP716dGjA76nY=;
        b=E3j3efMlmqmX0wF9OZgQYWPmPhKkGjjUkE6lq8KFz4fLAWrOvOzdDY9CFnJqt0wrS5mk2g
        oIa3yI7ZrXEL2bBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
In-Reply-To: <20200907095437.GD8084@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com> <20200904082438.20707-1-changki.kim@samsung.com> <874kod6fgh.fsf@jogness.linutronix.de> <20200904124530.GB20558@alley> <87y2lp4r6o.fsf@jogness.linutronix.de> <20200904151336.GC20558@alley> <87ft7xazsf.fsf@jogness.linutronix.de> <20200907095437.GD8084@alley>
Date:   Mon, 07 Sep 2020 12:36:45 +0206
Message-ID: <87d02xj2ui.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-07, Petr Mladek <pmladek@suse.com> wrote:
> This extra metadata are not currently read by crashdump tools.

crash [0] prints dictionary data.

John Ogness

[0] https://github.com/crash-utility/crash
