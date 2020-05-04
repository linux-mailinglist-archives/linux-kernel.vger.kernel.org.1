Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551741C365F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgEDKCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 May 2020 06:02:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgEDKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:02:10 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVXvM-0001Zo-L8
        for linux-kernel@vger.kernel.org; Mon, 04 May 2020 10:02:08 +0000
Received: by mail-pj1-f72.google.com with SMTP id bg6so8791803pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mwkkUiapeaLKnijBX2GICpmX1c9YuVtWjVfq3t3aBUE=;
        b=p1QWF+kmyk7njRprIVovq4aFyMElKNl+XeMujMqrCMB2YDtZGFp0XJOdefxrZHGEOP
         4UaB/Ds+Ejg1VfzhwmB1zGpkEwjT1CcNxkroDk9ItPXl5g7+mGpdnTe0S9bJe4TuCtih
         h0drg0cPfJOpgBvdxDK3HiLc35Acojr35lok7v/ikcDuFTPRsQnMKeslEH8a6MRG066G
         n7AMMRf8KokoDd2pekSiNDkKT4yQFJYyTRN55q2icJrLdIOhXbwn2fF0M4tziNEcwbpe
         dA86sKFahAiL2iA0mN67PHvAdzN44W3pyy17RiGf+OaAt3rbXMcx/imtjXpWsGycwXsh
         N0lg==
X-Gm-Message-State: AGi0PuY8iDMZQTudX6R82wfT2PY1siP4+WHqO5YwLME9EJXeG8c2nPbt
        hdECmZsduL81/h9xtz19QoeSCEhwswBBIcUGIz8PToDYTAccqkbQbvnOHG5aCYei+IbCyh9WSpp
        Kos5VqRRjZuMpZA2aj4gghzPwTpT5M7n9LTX5ssaZNA==
X-Received: by 2002:a63:3c0a:: with SMTP id j10mr12952911pga.373.1588586527267;
        Mon, 04 May 2020 03:02:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIu8mDtm9MeCRzvqNEih08I9J+LtybM+hiynuAFMTv20dUUB3DYwEkSydFKCC6oqDYDzWT/yQ==
X-Received: by 2002:a63:3c0a:: with SMTP id j10mr12952870pga.373.1588586526831;
        Mon, 04 May 2020 03:02:06 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id p1sm6864214pjf.15.2020.05.04.03.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 03:02:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] xhci: Prevent runtime suspend all the time with
 XHCI_RESET_ON_RESUME quirk
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1588585655.13662.5.camel@suse.com>
Date:   Mon, 4 May 2020 18:02:03 +0800
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <88A0FF32-C7D7-4E49-8470-FE23401371BD@canonical.com>
References: <20200504091952.15820-1-kai.heng.feng@canonical.com>
 <1588585655.13662.5.camel@suse.com>
To:     Oliver Neukum <oneukum@suse.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 4, 2020, at 17:47, Oliver Neukum <oneukum@suse.com> wrote:
> 
> Am Montag, den 04.05.2020, 17:19 +0800 schrieb Kai-Heng Feng:
>> Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
>> runtime suspended previously:
>> [  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> 
> Apparently this controller has issues with D3cold
> 
>> [  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
>> [  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
>> [  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>> [  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
>> [  370.080566] usb usb3: root hub lost power or was reset
>> [  370.080566] usb usb4: root hub lost power or was reset
>> [  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
>> [  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
>> [  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
>> [  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up
>> 
>> This can be fixed by not runtime suspend the controller at all.
>> 
>> So instead of conditionally runtime suspend the controller, always
>> prevent runtime suspend with XHCI_RESET_ON_RESUME quirk.
> 
> What does that do to other controllers that can do runtime suspend
> under the current scheme?

Ok, I'll add a new quirk specific to this controller.

Kai-Heng

> 
> 	Regards
> 		Oliver
> 

