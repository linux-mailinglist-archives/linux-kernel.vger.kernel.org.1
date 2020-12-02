Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19912CC862
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgLBUz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbgLBUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606942469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1bLnFlEWYKbw16R1IXidsvYoms+4PACYnhP+qrBmh0=;
        b=VsO0jDhyKwJDVFuA0JOtw0/X1P60GcO3lV1NAbySiQRzs5EvZDFGjBlD65a1ZIrsmPUuYz
        CwRXJcMWvxa6ulAIAEFrtXdexswD7IxnAQstcOQSysTDmd63gG+GmfDVMzvUCUsiISO4hG
        SPs29vQtHVPULa0Gx6gfqXIcTlCrm8U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-_0JMMaLWP2GyB_WYnXP8qg-1; Wed, 02 Dec 2020 15:54:28 -0500
X-MC-Unique: _0JMMaLWP2GyB_WYnXP8qg-1
Received: by mail-oi1-f199.google.com with SMTP id v5so1663338oig.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1bLnFlEWYKbw16R1IXidsvYoms+4PACYnhP+qrBmh0=;
        b=pk4K6Rs3c0kPtafo807kWt9alkw3ZxL+lC0XgcfTkOIfPzog8oTdXU5iTVVmhwUtGp
         +PWvnLUlvqKaQo7/Kov47Knek1YvcsJMuwI/dxCNZ0+Ney07gIk9Xs09RyH748zaX525
         VBfjirDeB3nL3xqkdy38VjXSdl/2UQwFktGQWWsT1m8MiN4FUAdKYPjo+NhZNRw597hj
         c7RyTTgc/loTTkYMgc3yAlR6wWVVMFUouOenYrYUE76+jX+/cThIE30DA/WfmR/x6N5+
         W9mnC0L0m7ES6ZLiOfYzEX+xufZOTsS79oQzfd0iRCeQr80o0HJm95teJvBM5vKnyAzV
         Tqmg==
X-Gm-Message-State: AOAM5303QM1sKI5VsAH7M2J12xB9wsZ+TS4K5gFbCeaCetrPz+m8YbKd
        DdigG88lJTmB0pT5Nr2i4K04zlyorXtcMBvztveqgMioQ8SXYE3WlGgi2Nwxe6Uhgc00uzmlo6u
        z4RN662MHaBeBVdpG6ZhWlbxjE0svIT6R/ILS6vKn
X-Received: by 2002:a4a:9cc7:: with SMTP id d7mr3116944ook.8.1606942467390;
        Wed, 02 Dec 2020 12:54:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwemcDixdv6gA+fb37ftXb6Dv3KTCWt/M/qExs75JZtNtb/GbFzEvTM+N3Ztast3lK9ic+UUcRiKYWi9Nxzaa8=
X-Received: by 2002:a4a:9cc7:: with SMTP id d7mr3116937ook.8.1606942467217;
 Wed, 02 Dec 2020 12:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20201123031716.6179-1-jarod@redhat.com> <20201202173053.13800-1-jarod@redhat.com>
 <14711.1606931728@famine> <CAKfmpSez1UYLG5nGYbMsRALGpEyXnwJcoFJV_7vALgpG3Xotcw@mail.gmail.com>
 <21153.1606940246@famine>
In-Reply-To: <21153.1606940246@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 2 Dec 2020 15:54:16 -0500
Message-ID: <CAKfmpScW_Ar91f1dd5QAeVmQa-G9c0qnJph+cBOJ_CoEGBoFpg@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix feature flag setting at init time
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:17 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >On Wed, Dec 2, 2020 at 12:55 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
> >>
> >> Jarod Wilson <jarod@redhat.com> wrote:
> >>
> >> >Don't try to adjust XFRM support flags if the bond device isn't yet
> >> >registered. Bad things can currently happen when netdev_change_features()
> >> >is called without having wanted_features fully filled in yet. Basically,
> >> >this code was racing against register_netdevice() filling in
> >> >wanted_features, and when it got there first, the empty wanted_features
> >> >led to features also getting emptied out, which was definitely not the
> >> >intended behavior, so prevent that from happening.
> >>
> >>         Is this an actual race?  Reading Ivan's prior message, it sounds
> >> like it's an ordering problem (in that bond_newlink calls
> >> register_netdevice after bond_changelink).
> >
> >Sorry, yeah, this is not actually a race condition, just an ordering
> >issue, bond_check_params() gets called at init time, which leads to
> >bond_option_mode_set() being called, and does so prior to
> >bond_create() running, which is where we actually call
> >register_netdevice().
>
>         So this only happens if there's a "mode" module parameter?  That
> doesn't sound like the call path that Ivan described (coming in via
> bond_newlink).

Ah. I think there's actually two different pathways that can trigger
this. The first is for bonds created at module load time, which I was
describing, the second is for a new bond created via bond_newlink()
after the bonding module is already loaded, as described by Ivan. Both
have the problem of bond_option_mode_set() running prior to
register_netdevice(). Of course, that would suggest every bond
currently comes up with unintentionally neutered flags, which I
neglected to catch in earlier testing and development.

-- 
Jarod Wilson
jarod@redhat.com

