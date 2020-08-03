Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9323A272
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHCKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 06:02:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHCKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:02:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596448967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LasRH/5iDOD64Y/0K4MJkcQgVXbHS/pVSieTxFLyVcc=;
        b=IwBnswyxoXiMxaFdNTBOzlMynvEwGb/qUehpejFfeJWssmqd/YPke710ggCtjqgkNyFk4N
        EueMVBvKJ5sOwFkYtQGrodfPWCwj8fyWhOpkfu9VDBdUc/2NfYZN8Qh3fO2TfXeQukeFZO
        SgWCQjd37aNf+ndJFnLUTJosJiIK9aN6mPA/lkTM6c3pNn9vX7hwBu7jn9OZnvikC1wu3P
        bzSuly8YNkiO8/wsoEX8+0omoFialRqUv9rsp2HpBP9ftYLtXKeHdmDqgpJU3vGeoyoVib
        sfOcOu4zXrd+cZrS9sO6iA0WHyeqeHDYsefOtSlTCU8TD0Pei3RJY2CqmcBJAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596448967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LasRH/5iDOD64Y/0K4MJkcQgVXbHS/pVSieTxFLyVcc=;
        b=mEaEZPHsTk/3+3ccCYY4WQk8QqIB4wIr/CQxYq05D7eEH9Jn9MiOj9WfCM5BQedjWTAaRQ
        NXpX4IJwPSnN2iDg==
To:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200803081625.czdfwcpw5emcd4ls@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <20200803081625.czdfwcpw5emcd4ls@skbuf>
Date:   Mon, 03 Aug 2020 12:02:46 +0200
Message-ID: <87o8nsm4hl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <olteanv@gmail.com> writes:
> On Mon, Aug 03, 2020 at 10:04:01AM +0200, Kurt Kanzenbach wrote:
>> Unfortunately I have no idea what to debug here.
>
> So, this means we could submit a formal version of this patch? :)

To paper over the underlying problem. Oh well...
