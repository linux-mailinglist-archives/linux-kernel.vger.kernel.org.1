Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49229398B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405111AbgJTLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:02:59 -0400
Received: from z5.mailgun.us ([104.130.96.5]:30933 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389626AbgJTLC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:02:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603191778; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kAkm6sAvGDwNl/euszSJwrz9w6URvbHJLkqO8372uDw=;
 b=uN6HPpYDhd+3q673dlySbhdqP6BNR0siSHrF31ab9OB6yI9yvHiPptGoCTtkbc0T67w+1Ju1
 9XIKqCipXswHff06IujDggrdW5BQc+0aMCL6vgxLpzpC+G6LIRx9mgBcijgOLiprQPCCTcyy
 /VUrM/KizxdlEDTTZTgMDhUH3CE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f8ec3e106d81bc48dcbdfe1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 11:02:57
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 624AEC433C9; Tue, 20 Oct 2020 11:02:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 874D0C433CB;
        Tue, 20 Oct 2020 11:02:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Oct 2020 19:02:56 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Jaegeuk Kim <jaegeuk@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 4/4] scsi: add more contexts in the ufs tracepoints
In-Reply-To: <CH2PR04MB6710F6367C3862F3107A78F5FC1F0@CH2PR04MB6710.namprd04.prod.outlook.com>
References: <20201005223635.2922805-1-jaegeuk@kernel.org>
 <20201005223635.2922805-4-jaegeuk@kernel.org>
 <f55c7b379283bfb90e884e9b1bdf170e@codeaurora.org>
 <CH2PR04MB6710F6367C3862F3107A78F5FC1F0@CH2PR04MB6710.namprd04.prod.outlook.com>
Message-ID: <14935822cbfa6d54df34946bcb2ccef8@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-20 18:51, Avri Altman wrote:
>> 
>> On 2020-10-06 06:36, Jaegeuk Kim wrote:
>> > From: Jaegeuk Kim <jaegeuk@google.com>
>> >
>> > This adds user-friendly tracepoints with group id.
> You have the entire cdb as part of the upiu trace,
> Can't you parse what you need from there?
> 
> Thanks,
> Avri

Yes, but assume we have a large trace log file, having a
groud id allows us to filter the data by it easily, right?

Thanks,

Can Guo.
