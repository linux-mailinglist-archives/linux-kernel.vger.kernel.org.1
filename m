Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749CD1EFFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFESTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:19:41 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434FC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 11:19:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c35so8202856edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqSUfhL+HpfxHMHLxeDxo+cffKJm8uC5qt8/bLSPpbQ=;
        b=KFZS46GFTZ9Gy3Cg/ohafbBdin5UVGOHBKY0W2wI6384HxS9k1vLbbdkOtccGTBnfl
         8XcGqVZeS/TWjJAU9xBTxX6LY+5e3X4A4jUvLcQ2fUqGlmj9zxKy89nhC7UsResG1jCn
         qcYVtf6k/prKJ895tWtyIpNpncfHOSytxbTBzmcHYmUtmZ5VtKm5h7WitDT3/e4vO2wb
         FeAk5ZwfXuLAHuSnbVvQTreK2q8TTD3kW2ol12V7p7CDK6LR5q9MgL+ZZM2BYHDuA3DN
         SGWwD6HEw6x3yX57rz+veZOXIf31k/GhdrbzYfVn74/XVgE4Qnr1acJHTuaoW0SjZHH+
         J/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqSUfhL+HpfxHMHLxeDxo+cffKJm8uC5qt8/bLSPpbQ=;
        b=PC9/YBHK18wpvZzWIUnfGHvmoNPIB3AyL5Tx23f38jIloxpxjIBDlDk33AIGLkIYwE
         2g+pbp+nfs5mNuftmWYMfaPC9to/dQQPpwdyuO3kdf8ty8zOeuOnHNFPolHNnNl7P/Xd
         nHirwIGmfAGgbNrBi710JQXxkiApZ74iIH3+WMl+8L/zM7olp1863u2J2WyfsldMi3NY
         aLAiLB+j9hQzHzPgzxwLcWe4GrI84HxHQjZiIBDTbzPLmjMkuKjRgwQ+Yy6XJ3yYpJOs
         0Ohbt3A/z6CdEojFiSbdM6suHKVP0g+BDw+lM8GSDjlFCjDNiBtjYiXD7O/7nrW8MWMc
         7D7A==
X-Gm-Message-State: AOAM530ODn74KHsAHOd0Uhd58A5+PqpgfMpW80qsLTnLU+nMcSmQAk5p
        gdkx+T129AVy5UA3sJMdVJ82GsAdieU2yT5CIKKiMA==
X-Google-Smtp-Source: ABdhPJwYKATWO9a3ADTUxQBAa8Nwr2+GQoHSj84HHGLL7MmG5YsI5pBuAWt+4WD3LOSfh0YCGx6dzCQDPaOgqo80aV8=
X-Received: by 2002:aa7:d6c1:: with SMTP id x1mr6359975edr.154.1591381179201;
 Fri, 05 Jun 2020 11:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101438.73929-1-vaibhav@linux.ibm.com> <20200602101438.73929-5-vaibhav@linux.ibm.com>
 <BN6PR11MB413223B333153721405DFD91C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
 <87h7vrgpzx.fsf@linux.ibm.com> <BN6PR11MB4132FA66A84CBD798AADCEC1C6860@BN6PR11MB4132.namprd11.prod.outlook.com>
 <873679h72g.fsf@linux.ibm.com>
In-Reply-To: <873679h72g.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 11:19:27 -0700
Message-ID: <CAPcyv4jcWc6HOW5dK1hp0vATDxd_mo+eVK=xkYMPOQ7t1fCv-A@mail.gmail.com>
Subject: Re: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for PAPR
 nvdimm specific methods
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 8:22 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
[..]
> > Oh, why not define a maximal health payload with all the attributes
> > you know about today, leave some room for future expansion, and then
> > report a validity flag for each attribute? This is how the "intel"
> > smart-health payload works. If they ever needed to extend the payload
> > they would increase the size and add more validity flags. Old
> > userspace never groks the new fields, new userspace knows to ask for
> > and parse the larger payload.
> >
> > See the flags field in 'struct nd_intel_smart' (in ndctl) and the
> > translation of those flags to ndctl generic attribute flags
> > intel_cmd_smart_get_flags().
> >
> > In general I'd like ndctl to understand the superset of all health
> > attributes across all vendors. For the truly vendor specific ones it
> > would mean that the health flags with a specific "papr_scm" back-end
> > just would never be set on an "intel" device. I.e. look at the "hpe"
> > and "msft" health backends. They only set a subset of the valid flags
> > that could be reported.
>
> Thanks, this sounds good. Infact papr_scm implementation in ndctl does
> advertises support for only a subset of ND_SMART_* flags right now.
>
> Using 'flags' instead of 'version' was indeed discussed during
> v7..v9. However re-looking at the 'msft' and 'hpe' implementations the
> approach of maximal health payload tagged with a flags field looks more
> intuitive and I would prefer implementing this scheme in this patch-set.
>
> The current set health data exchanged with between libndctl and
> papr_scm via 'struct nd_papr_pdsm_health' (e.g various health status
> bits , nvdimm arming status etc) are guaranteed to be always available
> hence associating their availability with a flag wont be much useful as
> the flag will be always set.
>
> However as you suggested, extending the 'struct nd_papr_pdsm_health' in
> future to accommodate new attributes like 'life-remaining' can be done
> via adding them to the end of the struct and setting a flag field to
> indicate its presence.
>
> So I have the following proposal:
> * Add a new '__u32 extension_flags' field at beginning of 'struct
>   nd_papr_pdsm_health'
> * Set the size of the struct to 184-bytes which is the maximum possible
>   size for a pdsm payload.
> * 'papr_scm' kernel driver will currently set 'extension_flag' to 0
>   indicating no extension fields.
>
> * Future patch that adds support for 'life-remaining' add the new-field
>   at the end of known fields in 'struct nd_papr_pdsm_health'.
> * When provided to  papr_scm kernel module, if 'life-remaining' data is
>   available its populated and corresponding flag set in
>   'extension_flags' field indicating its presence.
> * When received by libndctl papr_scm implementation its tests if the
>   extension_flags have associated 'life-remaining' flag set and if yes
>   then return ND_SMART_USED_VALID flag back from
>   ndctl_cmd_smart_get_flags().
>
> Implementing first 3 items above in the current patchset should be
> fairly trivial.
>
> Does that sounds reasonable ?

This sounds good to me.
