Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B575C2845DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgJFGOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:14:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgJFGOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:14:14 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 02:14:12 EDT
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14A8B7EAEC;
        Tue,  6 Oct 2020 02:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JosSPNpjBWcb
        KqfS+M6QynL4m+Y=; b=SRy5Ye8EoS2+BrD0ctceAn+/2pUuV+qCkn6l5/RRuKo1
        7HpXNlsvzUmrCxtnp0gUMLeSPANB/xFQDWhUsldTY1Nh3iV7sSxG7Ku3BKmnMnWq
        8TMYPxnYG1yOujKWBxaDiIEcXPdoyLzIg9RMAaTPFWr6zYi7rWI0WMv4HUzfkLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kHo57j
        rnA8Tk65fVXe5JMGpHEHwz15lHqH9C5VaB0iu/PPHXKR4J1Rp8LjlXGYFxpBpMdQ
        RVGG+z/lSaDTPfNfw7hFSbIKcwGZdqhAqPHeR2vpuKrSYnUX7Jj5WnFjz5gUga0m
        0jlym+OxLhjuwIZfkuhPa89Ur7BWiTeijRbBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D4157EAEA;
        Tue,  6 Oct 2020 02:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 885FB7EAE8;
        Tue,  6 Oct 2020 02:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
        <CAN0heSrKgNSHKDL07-BWrbF9n6fyWUZVDykdHPCD6CfwgV8QNA@mail.gmail.com>
Date:   Mon, 05 Oct 2020 23:08:30 -0700
In-Reply-To: <CAN0heSrKgNSHKDL07-BWrbF9n6fyWUZVDykdHPCD6CfwgV8QNA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 6 Oct 2020 05:57:02
 +0200")
Message-ID: <xmqqy2kj6g4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F0A4E96-079A-11EB-8A2E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Minor comments follow.
> ...
> s/used // (without 'g' flag!)


Thanks.
