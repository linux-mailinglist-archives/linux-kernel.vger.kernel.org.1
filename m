Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2229F6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgJ2VdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgJ2VdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:33:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A281C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:33:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so5796717ejg.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+1j9yhCsv5S7W6DriLq4jlIZu6jMQxN+78GLaGNINY=;
        b=ObwOf4Z+7QNvs8gO2kdUkeNUbXVbUl+Ox4/o49ffRqSzO+QYUS0pIhmO1RrB/D1yAF
         C6yCm356JTlV5mHsRf3G+RcKYRhKbb0eAo/psddMsacuHoU5dHNeIn4OaTLx5vRCHVqq
         otFhJR5d+BRHDTMd7/e1C943kvRVk+XIZsGUhDs69N6zq73w6ExLEoGQ/svlwtghQwHu
         KKbHbopA/PgFTFUOuopDjA43JlB2F3ABFnAXmxyB5zxZVWMAud3c9R5WPrHdpvIZmjgD
         SZs6SPXweM8G2yJQ0A+PzqOoucj0SN+5AGSzyk0hON4N5fe2icA/Jy49IE7W9PLggQPm
         rFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+1j9yhCsv5S7W6DriLq4jlIZu6jMQxN+78GLaGNINY=;
        b=NtGSlM8xORZftRl+nVNV8R7E7i2cwpuRQSdtVwSp9k8yBdqdPiU/oWagMO1/QqJalV
         DFvJksBAjQaEpFiKXsn3QWcF48+EhB/Ks9/bf3v72nufEnXfF5Wp/ydc5unYNEq1YZAd
         5wFoCLgQVi01DAJvGDg/Mqz7W97myiGwTUbLMZVp9+/ShPI63OPs+zm7Dtdvxwnhm7OQ
         XaJ/7gsigQ1Aq9kpmiYyyeid6BLs9afJA5mgMlF+tPe9Odj/PILKP9vjfxsWd7q2iSxw
         JnJzQIFEFFGuiQ5IG+4SqaB4t1rS0+r5lP1FNXIIAJq0ocOUn+esfI+pKDkOROWFCgHg
         eavg==
X-Gm-Message-State: AOAM5338xoyyUf4EkGc+xvLOhhMBwrvbGeYbqIl/meYtNES2LrB0p3UH
        lGTwMHamzJspkSfxAUn8jXTlD8bzPOZkqJgW99mQIw==
X-Google-Smtp-Source: ABdhPJxombUP9s0EeQ/sGwuRNegG5as7v5c4dUH02LUZNI2n09DlPyfVaA9wadMKASx9QXs+NebMeP12kOxoDEPNzpk=
X-Received: by 2002:a17:906:fa1b:: with SMTP id lo27mr3436193ejb.216.1604007189686;
 Thu, 29 Oct 2020 14:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230403.2445035-1-danielwinkler@google.com>
In-Reply-To: <20201001230403.2445035-1-danielwinkler@google.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Thu, 29 Oct 2020 14:32:58 -0700
Message-ID: <CAP2xMbtC0invbRT2q6LuamfEbE9ppMkRUO+jOisgtBG17JkrwA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Bluetooth: Add new MGMT interface for advertising add
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maintainers,

Just a friendly reminder to review this kernel patch series. I may
have accidentally named this series the same as the userspace series,
so I apologize if it has caused the set to be hidden in anybody's
inbox. I'll be sure not to do this in the future.

Thanks in advance for your time!

Best regards,
Daniel Winkler

On Thu, Oct 1, 2020 at 4:04 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hi Maintainers,
>
> This patch series defines the new two-call MGMT interface for adding
> new advertising instances. Similarly to the hci advertising commands, a
> mgmt call to set parameters is expected to be first, followed by a mgmt
> call to set advertising data/scan response. The members of the
> parameters request are optional; the caller defines a "params" bitfield
> in the structure that indicates which parameters were intentionally set,
> and others are set to defaults.
>
> The main feature here is the introduction of min/max parameters and tx
> power that can be requested by the client. Min/max parameters will be
> used both with and without extended advertising support, and tx power
> will be used with extended advertising support. After a call for hci
> advertising parameters, a new TX_POWER_SELECTED event will be emitted to
> alert userspace to the actual chosen tx power.
>
> Additionally, to inform userspace of the controller LE Tx power
> capabilities for the client's benefit, this series also changes the
> security info MGMT command to more flexibly contain other capabilities,
> such as LE min and max tx power.
>
> All changes have been tested on hatch (extended advertising) and kukui
> (no extended advertising) chromebooks with manual testing verifying
> correctness of parameters/data in btmon traces, and our automated test
> suite of 25 single- and multi-advertising usage scenarios.
>
> A separate patch series will add support in bluetoothd. Thanks in
> advance for your feedback!
>
> Daniel Winkler
>
>
> Changes in v4:
> - Add remaining data and scan response length to MGMT params response
> - Moving optional params into 'flags' field of MGMT command
> - Combine LE tx range into a single EIR field for MGMT capabilities cmd
>
> Changes in v3:
> - Adding selected tx power to adv params mgmt response, removing event
> - Re-using security info MGMT command to carry controller capabilities
>
> Changes in v2:
> - Fixed sparse error in Capabilities MGMT command
>
> Daniel Winkler (5):
>   Bluetooth: Add helper to set adv data
>   Bluetooth: Break add adv into two mgmt commands
>   Bluetooth: Use intervals and tx power from mgmt cmds
>   Bluetooth: Query LE tx power on startup
>   Bluetooth: Change MGMT security info CMD to be more generic
>
>  include/net/bluetooth/hci.h      |   7 +
>  include/net/bluetooth/hci_core.h |  12 +-
>  include/net/bluetooth/mgmt.h     |  49 +++-
>  net/bluetooth/hci_core.c         |  47 +++-
>  net/bluetooth/hci_event.c        |  19 ++
>  net/bluetooth/hci_request.c      |  29 ++-
>  net/bluetooth/mgmt.c             | 424 +++++++++++++++++++++++++++++--
>  7 files changed, 542 insertions(+), 45 deletions(-)
>
> --
> 2.28.0.709.gb0816b6eb0-goog
>
