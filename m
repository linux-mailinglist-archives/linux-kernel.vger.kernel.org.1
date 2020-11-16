Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E92B3D84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKPHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgKPHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:09:44 -0500
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Nov 2020 23:09:44 PST
Received: from mx3.uni-regensburg.de (mx3.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F4CC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:09:44 -0800 (PST)
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id F3448600004F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:02:04 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id E63DE600004D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:02:03 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 16 Nov 2020 08:02:02 +0100
Message-Id: <5FB223E8020000A10003CB88@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.0 
Date:   Mon, 16 Nov 2020 08:02:00 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <coreboot@coreboot.org>, <grub-devel@gnu.org>,
        <trenchboot-devel@googlegroups.com>, <x86@kernel.org>,
        <u-boot@lists.denx.de>,
        "systemd-devel@lists.freedesktop.org" 
        <systemd-devel@lists.freedesktop.org>,
        <xen-devel@lists.xenproject.org>, <daniel.kiper@oracle.com>,
        <linux-kernel@vger.kernel.org>
Cc:     <krystian.hebel@3mdeb.com>, <michal.zygowski@3mdeb.com>,
        <piotr.krol@3mdeb.com>, <mtottenh@akamai.com>,
        <luto@amacapital.net>, <dpsmith@apertussolutions.com>,
        <andrew.cooper3@citrix.com>, <roger.pau@citrix.com>,
        <allen.cryptic@gmail.com>, <btrotter@gmail.com>,
        <phcoder@gmail.com>, <lukasz.hawrylko@intel.com>,
        <ard.biesheuvel@linaro.org>, <tyhicks@linux.microsoft.com>,
        <pmenzel@molgen.mpg.de>, <hun@n-dimensional.de>,
        <leif@nuviainc.com>, <alexander.burmashev@oracle.com>,
        <eric.devolder@oracle.com>, <eric.snowberg@oracle.com>,
        <joao.m.martins@oracle.com>, <kanth.ghatraju@oracle.com>,
        <konrad.wilk@oracle.com>, <ross.philipson@oracle.com>,
        <javierm@redhat.com>, <pjones@redhat.com>, <alecb@umass.edu>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Antw: [EXT] [systemd-devel] [SPECIFICATION RFC] The firmware
 and bootloader log specification
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
In-Reply-To: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Daniel Kiper <daniel.kiper@oracle.com> schrieb am 14.11.2020 um 00:52 in
Nachricht <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>:
...
> The members of struct bf_log_msg:
>   ‑ size: total size of bf_log_msg struct,
>   ‑ ts_nsec: timestamp expressed in nanoseconds starting from 0,

Who or what defines t == 0?
...

Regards,
Ulrich Windl

