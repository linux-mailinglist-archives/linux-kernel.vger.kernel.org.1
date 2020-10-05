Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601082842E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJEXTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:19:10 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:33104 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJEXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:19:10 -0400
X-Greylist: delayed 66878 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 19:19:09 EDT
Date:   Mon, 05 Oct 2020 23:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601939947;
        bh=HaX8EWb9AzKpVCX5JpXpeCYdTLapnazuvdbKVj8g+DA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PIRoWzXG/J3TnUH9sop0aloO+uU7kCnDrF6wEdYm5GdkAjipX4es9fbFJyG76L1yR
         6j3gQn1FUs/i3JVHGDwUpmT4BPvevZcxC6hCWCQZbwG1SbdAEvFVEt+TmP0j58dglX
         dMRUU9nFkEjf1WaksX2N9BL2YSKk/OvjSrGjH9dQ=
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From:   "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Reply-To: "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Subject: Re: [PATCH] usb: host: ehci-sched: avoid possible NULL dereference
Message-ID: <brWYeL8miTAikvEPYFNe2Kpe05OBtiD6yuS6jRg1VCX-lt7ANc1B2y7AM6ECEoG9AJwZP5_5qoGO7POvK0MtruvqG8q8kHbyHiOUIZ72Klk=@protonmail.com>
In-Reply-To: <20201005213149.12332-1-sudipm.mukherjee@gmail.com>
References: <20201005213149.12332-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 5, 2020 5:31 PM, Sudip Mukherjee <sudipm.mukherjee@gmail=
.com> wrote:

> find_tt() can return NULL or the error value in ERR_PTR() and
> dereferencing the return value without checking for the error can
> lead to a possible dereference of NULL pointer or ERR_PTR().

Looks fine to me. There is in fact no checks of the return value
before a dereference here, and this solves that.

Reviewed-by: Harley A.W. Lorenzo <hl1998@protonmail.com
