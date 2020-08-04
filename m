Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989E23BEAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgHDRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgHDRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:11:58 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4135C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 10:11:57 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id q68so10057535uaq.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDe2U+JQQtlm6PkmOwl5fjQfHoZ0o3DW3eDHCm6kTvQ=;
        b=SoyMHVPkgxHGIyVFghEqt+dz76dWygdZK5qv96mgYHIB8BQDfnDSdlwicrCousdePt
         6kFYSc0n7RSJRhh/WbIBfAW1Mu0Sap9jaMdg6UlhNdK0k672HQpR0CmBGVutHlwlHgV+
         jMC83l8tqgA+ALlv4CakhMvyvvf1kF8Uhx/7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDe2U+JQQtlm6PkmOwl5fjQfHoZ0o3DW3eDHCm6kTvQ=;
        b=qq8mMetVoNQwh5a5QCic3D88EjVk+qrGIbxafeHcxTzXAAY3PS1aanz8Md1RnY8e4e
         EeN105JAsXzxbP+Fr8r9dn4UZ7bpOUBjgo9XE50SG5RyJgDfoOJUj287u5JwubctIU3Q
         v78tvL/PyKiA4pIjZkRneF5A/IGHO8nV7/UUNkBibqVfSSu04UAMcZfKmnvKiTjLm0Kd
         vU6UbHDRva7Cl2z2v+G6NC2B7O3R/jerwwEdRVgFbsKO9jkndqPZVzhafo0u3QASYaCO
         Cddfq5dRTnSPyo5Rgiqu01n+aqyfUO5ECIN5hnXBLne4Mu623KPVQCaoR1OmeX19k7VB
         ys4g==
X-Gm-Message-State: AOAM530MHHJEB8nCftH7tuwc2qVw16hFRWF98CA2Ik9gAq62XAe7Mhfw
        ZnN+xhm+SYZDPUREOLMZaYT9otxp9KipIb1AcWeYbQ==
X-Google-Smtp-Source: ABdhPJzdxejwD5qJ3tvpESkSc0h2CyPb4WDolKHYh5SfDmcf4Fg5xK3WK/bLFsJz2MfIniAOjYF53pvHQqw0ach4VHA=
X-Received: by 2002:a9f:2197:: with SMTP id 23mr15629203uac.60.1596561115676;
 Tue, 04 Aug 2020 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200729014225.1842177-1-abhishekpandit@chromium.org>
In-Reply-To: <20200729014225.1842177-1-abhishekpandit@chromium.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 4 Aug 2020 10:11:44 -0700
Message-ID: <CANFp7mV0TP-WbBWGSpduERaf9-KBXevhG7xKvjkMrqrtWWkZ5w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: Emit events for suspend/resume
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle reminder that this is waiting for feedback. Related userspace
changes are here to see how we plan on using it:
https://patchwork.kernel.org/project/bluetooth/list/?series=325777

Thanks
Abhishek

On Tue, Jul 28, 2020 at 6:42 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> Hi Marcel,
>
> This series adds the suspend/resume events suggested in
> https://patchwork.kernel.org/patch/11663455/.
>
> I have tested it with some userspace changes that monitors the
> controller resumed event to trigger audio device reconnection and
> verified that the events are correctly emitted.
>
> Please take a look.
> Abhishek
>
>
> Abhishek Pandit-Subedi (3):
>   Bluetooth: Add mgmt suspend and resume events
>   Bluetooth: Add suspend reason for device disconnect
>   Bluetooth: Emit controller suspend and resume events
>
>  include/net/bluetooth/hci_core.h |  6 +++
>  include/net/bluetooth/mgmt.h     | 16 +++++++
>  net/bluetooth/hci_core.c         | 26 +++++++++++-
>  net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             | 28 ++++++++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
