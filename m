Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171C02F6DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbhANWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:16:28 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4760 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbhANWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610662585; x=1642198585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ct4ddzB+6xF1iGrGz8eNn8YNE0snXKqmbVYwgCfBsnE=;
  b=XHLv2xZXO/v8jYkncmIckI9QGtuB1VPigAIbnmpvl+hr8quYPAbmYFvK
   grXyHOUu3FNvUs61dtqDloTGRRPp2MgxDL6qNCxRbZYeQ6Kzb/ZkzU7Fn
   X8yL/NMA/YhlzfgrduvegNY/5ad9EbKp+Xk5fwG87PkM/a434ShiV3bbN
   A=;
X-IronPort-AV: E=Sophos;i="5.79,347,1602547200"; 
   d="scan'208";a="112321323"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-e69428c4.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 Jan 2021 22:15:44 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-e69428c4.us-east-1.amazon.com (Postfix) with ESMTPS id 679FAC410B;
        Thu, 14 Jan 2021 22:15:43 +0000 (UTC)
Received: from EX13D49UWB004.ant.amazon.com (10.43.163.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Jan 2021 22:15:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D49UWB004.ant.amazon.com (10.43.163.111) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Jan 2021 22:15:42 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 14 Jan 2021 22:15:42 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9C686C225B; Thu, 14 Jan 2021 22:15:42 +0000 (UTC)
Date:   Thu, 14 Jan 2021 22:15:42 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Jessica Yu <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] module: harden ELF info handling
Message-ID: <20210114221542.GA24796@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20210107193001.12039-1-fllinden@amazon.com>
 <20210113144841.GB17705@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210113144841.GB17705@linux-8ccs>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 03:48:42PM +0100, Jessica Yu wrote:
> 
> 
[...]
> > +                      err = validate_section_offset(info, shdr);
> > +                      if (err < 0) {
> > +                              pr_err("Invalid ELF section in module (section %u type %u)\n",
> > +                                      i, shdr->sh_type);
> > +                              return err;
> > +                      }
> > +
> > +                      if (shdr->sh_flags & SHF_ALLOC) {
> > +                              if (shdr->sh_name >= strhdr->sh_size) {
> > +                                      pr_err("Invalid ELF section name in module (section num %u type %u)\n",
> 
> Small nit: Maybe remove "num", to be consistent with the other pr_err() above.

Sure, will do.

[...]
> > diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> > index 9d9fc678c91d..9a057c5d1d4d 100644
> > --- a/kernel/module_signing.c
> > +++ b/kernel/module_signing.c
> > @@ -30,7 +30,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> > 
> >       memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> > 
> > -      ret = mod_check_sig(&ms, modlen, info->name);
> > +      ret = mod_check_sig(&ms, modlen, info->name ?: "module");
> 
> Since info->name is not expected to be valid anymore, as we're back to
> calling mod_sig_check() first thing, perhaps just stick with
> "module"? Or was there another reason for checking info->name here?

It's mainly "what if mod_check_sig() is called differently in the future?",
but you are of course right: info->name will be NULL here. I'll change it
to just "module".

Thanks,

- Frank
