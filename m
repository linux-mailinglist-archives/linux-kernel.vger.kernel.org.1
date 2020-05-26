Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C211E32BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404441AbgEZWfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404420AbgEZWfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:35:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:34:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so10779692pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rc0ztywtDtdFivmaKBhxTDL3VYNzhzekzPPhJ2NZpLY=;
        b=K1w2VEUJFRCNmdKIEN6fzcAz45I8IqIXhkYy7dZoZ9CqByVri0wJpgw6ppL0Vf6shS
         E4VaBNm/EXE17Xdh/XAts/vxCFDPtf80lqfWWmKDhXo6uMUdbnnykRrEBYka1DMDoJxW
         Kne0gM4h8M9f1d/SLaE05gxVF4ETTfdya61DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rc0ztywtDtdFivmaKBhxTDL3VYNzhzekzPPhJ2NZpLY=;
        b=e1brKe5F9q2uMWbAtIGO/eHVW6N2bppPjz+69NkxAfYIVso5YXnxiv+K+7ZiEDyQ3Y
         VfLptYVW24N3boDHLCQpuFwcMC4WlxbXuE6Mq03ODTJXUfUTgp2SY89/K/wU/6hh7HFv
         Pk0+bj67ROC7yZYXXvTx/342KI5O8HBzpeFpwpElKapOJ0gEojI3Dmf1/NIAqriPCaJP
         MUhD85gCTZwR4XdxIBNtKPHOpqJDvzwbrkOEz8dpNMSyc7zMHidc9xjOzUWIFltZi4+e
         I8PHQfSzZ2ziHdnZdfMcFuIYBKtcQyPYl/4ATMKoUBuGF+QDJ1O4T1t5XcB+DJrPW//G
         VSUg==
X-Gm-Message-State: AOAM532Z7yGWr8mL+NVnHtawarBlkBnO/Oq2HKNRKQy5ocEJPqeNMJ3G
        T7DPjl/U6i72btzIcNErkBmxRg==
X-Google-Smtp-Source: ABdhPJxIlsZhEzNp6s/vSULhJkeORRxVKjicky1gfALAqUj9Gulp50o+6Cqs0SfnDwlQt9iAfHNpzA==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr980505pfi.199.1590532498863;
        Tue, 26 May 2020 15:34:58 -0700 (PDT)
Received: from ?IPv6:2601:645:4000:ba:30d8:f462:8a0e:6cae? ([2601:645:4000:ba:30d8:f462:8a0e:6cae])
        by smtp.gmail.com with ESMTPSA id s94sm507942pjb.20.2020.05.26.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:34:57 -0700 (PDT)
Message-ID: <1fc66c1b942e5c0855cea3445bfe33fc3a1c1ad2.camel@guzman.io>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   Alex Guzman <alex@guzman.io>
To:     Tadeusz Struk <tstruk@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Date:   Tue, 26 May 2020 15:34:56 -0700
In-Reply-To: <705c9df6-e8cd-2829-c579-2bf039360eec@gmail.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
         <1590523214.15108.4.camel@HansenPartnership.com>
         <705c9df6-e8cd-2829-c579-2bf039360eec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 14:33 -0700, Tadeusz Struk wrote:
> On 5/26/20 1:00 PM, James Bottomley wrote:
> > I don't think there is a root cause other than a TIS TPM is getting
> > annoyed by us cycling localities too rapidly because we don't do an
> > actual TPM operation between request and relinquish.  Since the
> > first
> > request/relinquish seems unnecessary for the async case, moving the
> > ops
> > get eliminates the problem.
> 
> Could be, so maybe we could try both patches.
> More debug info on the error path won't hurt.
> Thanks,
> Tadeusz

With your logging patch, I consistently see this message in dmesg when
tpm2_getcap fails:

tpm tpm0: request_locality: failed to request locality 0 after 750 ms

