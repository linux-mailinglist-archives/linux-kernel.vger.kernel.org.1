Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB21D77FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERLzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:55:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:55:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D392D106F;
        Mon, 18 May 2020 04:55:50 -0700 (PDT)
Received: from bogus (unknown [10.37.12.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 328D33F305;
        Mon, 18 May 2020 04:55:49 -0700 (PDT)
Date:   Mon, 18 May 2020 12:55:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 7/7] firmware: smccc: Add ARCH_SOC_ID support
Message-ID: <20200518115546.GB16262@bogus>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <20200518091222.27467-8-sudeep.holla@arm.com>
 <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:30:21AM +0200, Arnd Bergmann wrote:
> On Mon, May 18, 2020 at 11:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > +static ssize_t
> > +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> > +                          char *buf)
> > +{
> > +       return sprintf(buf, "0x%02x\n", JEP106_BANK_CONT_CODE(soc_id_version));
> > +}
> > +
> > +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> > +
> > +static ssize_t
> > +jep106_identification_code_show(struct device *dev,
> > +                               struct device_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf, "0x%02x\n", JEP106_ID_CODE(soc_id_version));
> > +}
>
> I think we should try hard to avoid nonstandard attributes for the soc device.
>

I agree with that in general but this is bit different for below mentioned
reason.

> Did you run into a problem with finding one of the existing attributes
> that can be used to hold the fields?
>

Not really! The 2 JEP106 codes can be used to derive the manufacturer which
could match one of the existing attributes. However doing so might require
importing the huge JEP106 list as it needs to be maintained and updated
in the kernel. Also that approach will have the compatibility issue and
that is the reason for introducing these attributes representing raw
values for userspace.

--
Regards,
Sudeep
