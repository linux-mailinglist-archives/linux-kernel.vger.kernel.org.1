Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF131ACDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391992AbgDPQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732468AbgDPQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:27:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58ACC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so6078317ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5DsdlMWlvuKqdtofFGPhOBVDzjYRJgpB+utt/BhA+Gg=;
        b=wUMC0iiCB0tQ1cxYbtN02WiSpx8JmnyaLU5ZLLvSd1FVmiW0lGTTIM0Yc6qs5MfpYB
         /NnHD75ZXPbMPmND6SalTeHbMOH2QfztZ619tbR5Pr0OezsUZLYJ75KHQ2ISCusbNp3y
         Zoy3lFwZfvt5XHYCnUmTPrCcYusEZZsxDp60qXBJCrtGNe+sci7LBs6HDM8OjhPJ0Hyj
         1O5XGyw3A/7/pwTGUbS1t0dBgol6qHj+BU0c1J2/udEV5dkhApZ6GTi9YBFmsVljCujI
         X43Zsj85uzCfki6E3pI/dqd3K2blN6FnoG+nhHmcPgEdRBg2doNye7GZYCUdNU48RtDn
         fvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5DsdlMWlvuKqdtofFGPhOBVDzjYRJgpB+utt/BhA+Gg=;
        b=mOWgg+oefYAS5rr6JG4MixPwdC8ID7dP9er1r3hMKbch5J8ywy6Hzrca5V0l6V9cWR
         4pDAkVOKmeu5jYIL8rXsD6lZ51aQGiRDkatcGeDlBY6nYJgQR+Lj1fwesVZkdNRKNzUp
         N4ozivRLcaVNJCkPKI9iJ0eRviEcqpgSCkcBrUYyD/ziGNWtv89WjjdrD1dDzTG+x9Wk
         xg6U2diqrkc9YiUwKAlpAEiqdpr+3TB8yftUjmblsM6QULvDy5CTzTfMJAc7KbPdb4bX
         loWNEH5KiZcCBkefRUCaM/uGTRy2BMvz04s0EiEaVVUfOmzD3iiDXXUMT/sxn/7ShdMR
         0yOA==
X-Gm-Message-State: AGi0PuaMcPkv27SyDshU/Y+737P73HZl9+L72EbiEtbd/3AwECBgSlld
        OM6yd5yNLn0ZMz9VW/w2NQD41/X40OQvnQ==
X-Google-Smtp-Source: APiQypJ0dfbckQxr1NrwNvt7cHhmbz6qQidF/3io3d3O3dqzN970+sNdaHNdcctW3wgajOCqL3gYuA==
X-Received: by 2002:a92:d44e:: with SMTP id r14mr9721711ilm.244.1587054442072;
        Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d10sm7251313ilu.46.2020.04.16.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:27:21 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH-U PCI ID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200416063540.30462-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b04c4e8-32f1-216e-055d-5ba2e1052750@kernel.dk>
Date:   Thu, 16 Apr 2020 10:27:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416063540.30462-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 12:35 AM, Kai-Heng Feng wrote:
> Add Intel Comet Lake PCH-U PCI ID to the list of supported controllers.
> 
> Set default SATA LPM so the SoC can enter S0ix.

Applied, thanks.

-- 
Jens Axboe

