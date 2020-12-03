Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6E2CE328
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgLCXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:54:26 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:42586 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgLCXyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:54:25 -0500
Date:   Thu, 03 Dec 2020 23:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1607039582;
        bh=76cnCDcbV+bVOdYRaXnr4zF98Zu9UULsK0fglJwpWlQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=WzERO6BYSIsKO3lezFEOihwh3Ru+D1+tvnT3ptqi28Uqn0Mb4wE+XvLLF+3x8FrNZ
         7sYKKCP9jcyKH1cVoLkQhSqAbJDifVD7IRHLS/ywMWXKwqk1K4NHfLDm7FYv9C1wHe
         oPYMeLCCfVL+og6+mRxG29hWmJkHTzPwojmiS3mI=
To:     Elia Devito <eliadevito@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 2/2] intel-hid: add alternative method to enable switches
Message-ID: <dZOYAwID-kLArecWZIijmPEsGIBufXoFhTl6ueCv-rXqxZow2klBtVhCB6b9OQhjTsb5zRSSBE7tlB25Za1A_VUBlzlk-vlMQb6SzBeVkzY=@protonmail.com>
In-Reply-To: <u_tIRoW7nG4DQc7H_wcr9yn8oIc5rO9SsWKfOoJz4c9KKDJtUsYore_4tyNYxn3r0OpEOI5rsyrE__1Y2hbIc8lnS5cJKeeFmqyPdRjDVyU=@protonmail.com>
References: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com> <20201203212148.36039-1-eliadevito@gmail.com> <u_tIRoW7nG4DQc7H_wcr9yn8oIc5rO9SsWKfOoJz4c9KKDJtUsYore_4tyNYxn3r0OpEOI5rsyrE__1Y2hbIc8lnS5cJKeeFmqyPdRjDVyU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020. december 4., p=C3=A9ntek 0:45 keltez=C3=A9ssel, Barnab=C3=A1s P=C5=
=91cze =C3=ADrta:

> Hi
>
> [...]


Oh well, I replied to the wrong email, apologies. :-(
