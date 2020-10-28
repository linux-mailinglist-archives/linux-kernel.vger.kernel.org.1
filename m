Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88029D525
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgJ1V65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:58:57 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:35975 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbgJ1V6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603922335; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=B38mMIzITGT8PJaao7b5c6lhDRqKzAlKVY/jp8d0p1M=;
 b=QbAHm+lPxS5hnlKsdYr/M1EpNxXb7KLHXnDI+FKxfNK3n/kWr8AoCg4LsndXmkZonNLQgvfi
 akUHSc7kT1tFO9MSLknnlaBk3nx96W9ORyXpTa/VE7a+njtI2QFZPXOZwPe9nKcCZ+hkJLIh
 BV2MstZL2jO5L/mUbqNOnTokcW4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f99cdeb99d22f6577a0e17e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 20:00:43
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20F4EC433FE; Wed, 28 Oct 2020 20:00:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F36EC433CB;
        Wed, 28 Oct 2020 20:00:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Oct 2020 13:00:42 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     =?UTF-8?Q?Carl_Yin=28=E6=AE=B7=E5=BC=A0=E6=88=90=29?= 
        <carl.yin@quectel.com>
Cc:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org,
        sfr@canb.auug.org.au, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naveen Kumar <naveen.kumar@quectel.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_bus=3A_mhi=3A_?=
 =?UTF-8?Q?core=3A_Fix_null_pointer_access?=
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <HK2PR06MB3507360AE3E2D14FA9DE90C286170@HK2PR06MB3507.apcprd06.prod.outlook.com>
References: <41058752035efde392e1c55d0fd5b58c@sslemail.net>
 <b3bf32de1f3580210ebad6c4b2c7a802@codeaurora.org>
 <HK2PR06MB3507360AE3E2D14FA9DE90C286170@HK2PR06MB3507.apcprd06.prod.outlook.com>
Message-ID: <4a02c189fab49b75dc827fa54fe69663@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 19:03, Carl Yin wrote:
> Hi bbhatt:
> 
> On Wednesday, October 28, 2020 9:02 AM, bbhatt wrote:
> 
>> Hi Carl,
>> 
>> Yes this change is needed. Good catch. I ran in to this issue as well 
>> when a
>> dev_err() call was made with a bad MHI configuration.
> [carl.yin] yes, I also meet this error with a bad MHI configuration.
>> 
>> Maybe you can explain a little more in the commit text subject?
>> 
>> You could say, "Fix null pointer access when parsing MHI 
>> configuration"?
>> 
>> On 2020-10-26 22:33, carl.yin@quectel.com wrote:
>> > From: carl <carl.yin@quectel.com>
>> >
>> > function parse_ev_cfg and parse_ch_cfg access mhi_cntrl->mhi_dev
>> Functions parse_ev_cfg() and parse_ch_cfg()
>> > before it is set in function mhi_register_controller,
>> mhi_register_controller()
>> > use cntrl_dev to instead mhi_dev.
>> use cntrl_dev instead of mhi_dev.
>> >
>> > Signed-off-by: carl <carl.yin@quectel.com>
>> With these commit text updates,
> [carl.yin] thank for words correction, for my mother language is not 
> English,
> there are lots of words wrong in the commit.
>> 
No problem.
>> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> > ---
>> >  drivers/bus/mhi/core/init.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
>> > index 0ffdebde8..c6b43e90b 100644
>> > --- a/drivers/bus/mhi/core/init.c
>> > +++ b/drivers/bus/mhi/core/init.c
>> > @@ -610,7 +610,7 @@ static int parse_ev_cfg(struct mhi_controller
>> > *mhi_cntrl,  {
>> >  	struct mhi_event *mhi_event;
>> >  	const struct mhi_event_config *event_cfg;
>> > -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> > +	struct device *dev = mhi_cntrl->cntrl_dev;
>> >  	int i, num;
>> >
>> >  	num = config->num_events;
>> > @@ -692,7 +692,7 @@ static int parse_ch_cfg(struct mhi_controller
>> > *mhi_cntrl,
>> >  			const struct mhi_controller_config *config)  {
>> >  	const struct mhi_channel_config *ch_cfg;
>> > -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> > +	struct device *dev = mhi_cntrl->cntrl_dev;
>> >  	int i;
>> >  	u32 chan;
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum, a
>> Linux Foundation Collaborative Project

Can you also add a "Fixes:" tag to the patch?

Refer Documentation/process/submitting-patches.rst:

If your patch fixes a bug in a specific commit, e.g. you found an issue 
using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters 
of
the SHA-1 ID, and the one line summary.  Do not split the tag across 
multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to 
simplify
parsing scripts.  For example::

	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the 
number of pages it actually freed")

Thanks,
Bhaumik
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
