Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6712E2318
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 01:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLXAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 19:49:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57497 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgLXAtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 19:49:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60DA09AD9B;
        Wed, 23 Dec 2020 19:48:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=heULSe
        +gSvEQTZpFdomonzDXux78+xKFv29rd/JXLl9BWVZHhG/YH4xWObZ5AJN7OOI0iC
        YK+0Nn8GbKL7BMtaYqv9n3ZbJdGjkNm79PEyNtJ/v0Vr0ZmoSh/MmZMli6LVmX+3
        jwehz7w5akGulLPvuP1idIoYjl/wIliE48LNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLCL+8JNO17SMwKwVlLp+5dE3wwUGo/4
        mglsNI2Ml4pp0/+7xsCu3O7FnuwddTRhIutpNS8nIwAR3ys3IcPWdhFqnwV3tqHr
        FHR9IQkJGqHIrXeep1+KCU79LZZfa+82XlcPJZpSQ8TV5U1ItZTnLYXVDdQhABcu
        VMz04j56Cic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E179AD9A;
        Wed, 23 Dec 2020 19:48:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C65F99AD98;
        Wed, 23 Dec 2020 19:48:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.30.0-rc2
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
        <20201224002237.GY748@pobox.com>
Date:   Wed, 23 Dec 2020 16:48:36 -0800
In-Reply-To: <20201224002237.GY748@pobox.com> (Todd Zullinger's message of
        "Wed, 23 Dec 2020 19:22:37 -0500")
Message-ID: <xmqqr1ng3u6z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1BAFFE8-4581-11EB-8BFB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
