Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC831F46AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgFISyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgFISyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:54:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5CC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:54:02 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w7so17235648edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yN34Kwv8IRFc+9e78Q6mCK1MyYg8BkS9smGOwMqsWo=;
        b=0vF50pzhPpHsKZkoDioXybWZC7MNqfr0Bknr5fPXDGuBiaT3eg8byaeLcN7CFHnndB
         WU8WTv1oZ4dtyzLqZFLB9i7yrAWs0Kd1nKYjH00NoNt/ktKfsluWtbNiyWDttVcNlLBS
         Prbme46vzXU+lB5pgRvgKZY0LoZcnhgs7B98IZX9Exxc8w007OKojGiPHgeBEwSRaOon
         T5CyALu5pwykBlpMXpRRNcjbYM3TGvbAJn6wvd1vvSxbz/SpycOboN1w0G3rIURYxncC
         bETcNy6I6FJCaRp30ZfsMfg5WA4JS9jTJFMi8IVLU5hbCdMPCX1qNw+Emk30dNRNRds4
         nCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yN34Kwv8IRFc+9e78Q6mCK1MyYg8BkS9smGOwMqsWo=;
        b=jZfhghlISdd2rb/l4jMJ+wiSKDMoC8OhWTzqk9aL+O87ERrjriygXE4NgSN2Xg2iGS
         PA+sN36YGrZiSaSDwIHRfwg8yCx0tjUJvAJmyAv+2hjqM8nWvmz7YQOMPgkH5524QHSa
         dICUZ8U44WjkCWHobRiZO6NHsT8Ksp0g9OZ/nXjnt3uVCF4sZyafRGeFUtC6l0jopSWx
         HYBczIj9xHfhVaJacq2E600vN2P5tZ4AflBZ+GDO9RvidP3PMTdSenaaBA7bzmSGOPjk
         6dl0YOZ7JgxqDPwmKFjbmgGHzPAejUgVqGIlxLfTZot0sLGS7FIVbw3Yh9cXViuMWALR
         /0yA==
X-Gm-Message-State: AOAM532TG0SC+WrubapKQXszQjhiBdBtyGzdjpYv5j64MgXVg9VooLAS
        ZVduJOaCNuIoj4pccubo1uZ/w4WYzuLFL1/LC6Gamw==
X-Google-Smtp-Source: ABdhPJyvthCFMORu6zpkQue1Ml/wcE3nULbuHQKyDNQ8kucKSQqrx5ZUoA51HbypmR9uFuqK6YoYmsuDrZ30g+IcX6s=
X-Received: by 2002:aa7:c489:: with SMTP id m9mr29842316edq.102.1591728841084;
 Tue, 09 Jun 2020 11:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200607131339.476036-6-vaibhav@linux.ibm.com>
 <202006090059.o4CE5D9b%lkp@intel.com> <CAPcyv4iQo_xgRGPx_j+RPzgWGZaigGRbc_kRzKEFePfVHenx5g@mail.gmail.com>
 <87mu5cw2gl.fsf@linux.ibm.com>
In-Reply-To: <87mu5cw2gl.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Jun 2020 11:53:49 -0700
Message-ID: <CAPcyv4jfeBoFCdg2sKP5ExpTTQ_+LyrJewTupcrTgh-qWykNxw@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 10:54 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Thanks Dan for the consideration and taking time to look into this.
>
> My responses below:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Mon, Jun 8, 2020 at 5:16 PM kernel test robot <lkp@intel.com> wrote:
> >>
> >> Hi Vaibhav,
> >>
> >> Thank you for the patch! Perhaps something to improve:
> >>
> >> [auto build test WARNING on powerpc/next]
> >> [also build test WARNING on linus/master v5.7 next-20200605]
> >> [cannot apply to linux-nvdimm/libnvdimm-for-next scottwood/next]
> >> [if your patch is applied to the wrong git tree, please drop us a note to help
> >> improve the system. BTW, we also suggest to use '--base' option to specify the
> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Vaibhav-Jain/powerpc-papr_scm-Add-support-for-reporting-nvdimm-health/20200607-211653
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> >> config: powerpc-randconfig-r016-20200607 (attached as .config)
> >> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # install powerpc cross compiling tool for clang build
> >>         # apt-get install binutils-powerpc-linux-gnu
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >>
> >> In file included from <built-in>:1:
> >> >> ./usr/include/asm/papr_pdsm.h:69:20: warning: field 'hdr' with variable sized type 'struct nd_cmd_pkg' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> >> struct nd_cmd_pkg hdr;  /* Package header containing sub-cmd */
> >
> > Hi Vaibhav,
> >
> [.]
> > This looks like it's going to need another round to get this fixed. I
> > don't think 'struct nd_pdsm_cmd_pkg' should embed a definition of
> > 'struct nd_cmd_pkg'. An instance of 'struct nd_cmd_pkg' carries a
> > payload that is the 'pdsm' specifics. As the code has it now it's
> > defined as a superset of 'struct nd_cmd_pkg' and the compiler warning
> > is pointing out a real 'struct' organization problem.
> >
> > Given the soak time needed in -next after the code is finalized this
> > there's no time to do another round of updates and still make the v5.8
> > merge window.
>
> Agreed that this looks bad, a solution will probably need some more
> review cycles resulting in this series missing the merge window.
>
> I am investigating into the possible solutions for this reported issue
> and made few observations:
>
> I see command pkg for Intel, Hpe, Msft and Hyperv families using a
> similar layout of embedding nd_cmd_pkg at the head of the
> command-pkg. struct nd_pdsm_cmd_pkg is following the same pattern.
>
> struct nd_pdsm_cmd_pkg {
>     struct nd_cmd_pkg hdr;
>     /* other members */
> };
>
> struct ndn_pkg_msft {
>     struct nd_cmd_pkg gen;
>     /* other members */
> };
> struct nd_pkg_intel {
>     struct nd_cmd_pkg gen;
>     /* other members */
> };
> struct ndn_pkg_hpe1 {
>     struct nd_cmd_pkg gen;
>     /* other members */

In those cases the other members are a union and there is no second
variable length array. Perhaps that is why those definitions are not
getting flagged? I'm not seeing anything in ndctl build options that
would explicitly disable this warning, but I'm not sure if the ndctl
build environment is missing this build warning by accident.

Those variable size payloads are also not being used in any code paths
that would look at the size of the command payload, like the kernel
ioctl() path. The payload validation code needs static sizes and the
payload parsing code wants to cast the payload to a known type. I
don't think you can use the same struct definition for both those
cases which is why the ndctl parsing code uses the union layout, but
the kernel command marshaling code does strict layering.

> };
>
> Even though other command families implement similar command-package
> layout they were not flagged (yet) as they are (I am guessing) serviced
> in vendor acpi drivers rather than in kernel like in case of papr-scm
> command family.

I sincerely hope there are no vendor acpi kernel drivers outside of
the upstream one.

>
> So, I think this issue is not just specific to papr-scm command family
> introduced in this patch series but rather across all other command
> families. Every other command family assumes 'struct nd_cmd_pkg_hdr' to
> be embeddable and puts it at the beginning of their corresponding
> command-packages. And its only a matter of time when someone tries
> filtering/handling of vendor specific commands in nfit module when they
> hit similar issue.
>
> Possible Solutions:
>
> * One way would be to redefine 'struct nd_cmd_pkg' to mark field
>   'nd_payload[]' from a flexible array to zero sized array as
>   'nd_payload[0]'.

I just went through a round of removing the usage of buf[0] in ndctl
since gcc10 now warns about that too.

> This should make 'struct nd_cmd_pkg' embeddable and
>   clang shouldn't report 'gnu-variable-sized-type-not-at-end'
>   warning. Also I think this change shouldn't introduce any ABI change.
>
> * Another way to solve this issue might be to redefine 'struct
>   nd_pdsm_cmd_pkg' to below removing the 'struct nd_cmd_pkg' member. This
>   struct should immediately follow the 'struct nd_cmd_pkg' command package
>   when sent to libnvdimm:
>
>   struct nd_pdsm_cmd_pkg {
>         __s32 cmd_status;       /* Out: Sub-cmd status returned back */
>         __u16 reserved[2];      /* Ignored and to be used in future */
>         __u8 payload[];
>         };
>
>   This should remove the flexible member nc_cmd_pkg.nd_payload from the
>   struct with just one remaining at the end. However this would make
>   accessing the [in|out|fw]_size members of 'struct nd_cmd_pkg'
>   difficult for the pdsm servicing functions.
>
>
> Any other solution that you think, may solve this issue ?

The union might help, but per the above I think only for parsing the
command at which point I don't think the kernel needs a unified
structure defining both the generic envelope and the end-point
specific payload at once.
