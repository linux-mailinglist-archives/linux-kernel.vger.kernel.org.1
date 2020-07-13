Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8E2194F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 20:20:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:49545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgGIAUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:20:18 -0400
IronPort-SDR: Q854TbIZ4Q32v+HO+02ZTJfAL0bieD1N62FBPNUS2zS1ifxuPoOWS/en78Av+Ydz3jFgU5M227
 ndIrx/RhE2TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146992855"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="146992855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 17:20:17 -0700
IronPort-SDR: BnZW8KVeCEeTPl44irgEhsvpRpY3hm7U00/IUsQmP0IYaOy2E6uKDHKYLNXnj51sj7nkzml6K5
 ++lJ0dj9ZAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="483590207"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jul 2020 17:20:14 -0700
Date:   Thu, 9 Jul 2020 08:20:28 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Xia, Hui" <hui.xia@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, lkp <lkp@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be
 populated
Message-ID: <20200709002028.GA12731@intel.com>
References: <20200630021436.43281-1-richard.weiyang@linux.alibaba.com>
 <202007010217.Rut2zTnF%lkp@intel.com>
 <20200701115816.GB4979@L-31X9LVDL-1304.local>
 <MN2PR11MB4064B0104312A3D22F1698F3E5670@MN2PR11MB4064.namprd11.prod.outlook.com>
 <CAKwvOdkVqY8WAfdTtHbgnJ2jafvsJCUgx2Rx4PCeNiX7HjLLow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkVqY8WAfdTtHbgnJ2jafvsJCUgx2Rx4PCeNiX7HjLLow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:20:26AM -0700, Nick Desaulniers wrote:
> On Wed, Jul 8, 2020 at 12:23 AM Xia, Hui <hui.xia@intel.com> wrote:
> >
> >
> >
> > >-----Original Message-----
> > >From: Wei Yang <richard.weiyang@linux.alibaba.com>
> > >Sent: 2020年7月1日 19:58
> > >To: lkp <lkp@intel.com>
> > >Cc: Wei Yang <richard.weiyang@linux.alibaba.com>; Williams, Dan J
> > ><dan.j.williams@intel.com>; akpm@linux-foundation.org; kbuild-all@lists.01.org;
> > >clang-built-linux@googlegroups.com; linux-mm@kvack.org; linux-
> > >kernel@vger.kernel.org
> > >Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be
> > >populated
> > >
> > >On Wed, Jul 01, 2020 at 02:11:10AM +0800, kernel test robot wrote:
> > >>Hi Wei,
> > >>
> > >>Thank you for the patch! Perhaps something to improve:
> > >>
> > >>[auto build test WARNING on mmotm/master]
> > >>
> > >>url:    https://github.com/0day-ci/linux/commits/Wei-Yang/mm-sparse-only-
> > >sub-section-aligned-range-would-be-populated/20200630-101713
> > >>base:   git://git.cmpxchg.org/linux-mmotm.git master
> > >>config: x86_64-allnoconfig (attached as .config)
> 
> Another issue was that this was an allnoconfig x86_64 build with
> Clang.  While ARCH=x86_64 defconfigs set:
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> 
> allnoconfig turns those off, making it a 32b x86 build.  We cannot yet
> build an ARCH=i386 build yet with Clang, so that means this target is
> not green to begin with.
> 
> + Arnd
> There might be a way for us to disable maybe CONFIG_X86_32 when
> building with Clang?  or make it so that randconfig can't dig this up?
> 
> +Philip
> I'm not sure if it's easy to disable `allnoconfig` x86 builds with
yes, this is easy, we will disable the build w/ clang in this situation.

> Clang?  Also, I feel like we're asking for a bunch of special cases
> while we work through all the issues.  We would like to revert these
> special cases once we're in better shape.  Are you tracking a list of
> exceptions, so that we can estimate the work to fix on our side, and
> that we know to re-enable test coverage once fixed?
It is not that formally tracked, though it is controlled in the code
to know what is currently disabled. Currently we may not know when
it can be opened, thus we check the ClangBuiltLinux sometimes to see
progress of interested issues.

> 
> > >>compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> > >>cf1d04484344be52ada8178e41d18fd15a9b880c)
> > >>reproduce (this is a W=1 build):
> > >>        wget https://raw.githubusercontent.com/intel/lkp-
> > >tests/master/sbin/make.cross -O ~/bin/make.cross
> > >>        chmod +x ~/bin/make.cross
> > >>        # install x86_64 cross compiling tool for clang build
> > >>        # apt-get install binutils-x86-64-linux-gnu
> > >>        # save the attached .config to linux build tree
> > >>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > >>ARCH=x86_64
> > >>
> > >>If you fix the issue, kindly add following tag as appropriate
> > >>Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >
> > >Sorry, I don't follow up with this error report.
> > >
> > >It looks like a build error, while I just removes some check and the build pass from
> > >my side. Confused with this error report.
> > It is false positive. Please ignore. Sorry for inconvenience.
> > The report complains about " warning: no previous prototype for function 'devkmsg_sysctl_set_loglvl'" which is not caused by commit in this report. We will investigate and fix in 0-day side.
> >
> > >
> > >>All warnings (new ones prefixed by >>):
> > >>
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>   case 1: ^
> > >>   include/linux/signal.h:177:1: warning: unannotated fall-through between
> > >switch labels
> > >>   _SIG_SET_OP(signotset, _sig_not)
> > >>   ^
> > >>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP'
> > >>   case 2: = ^
> > >>   include/linux/signal.h:177:1: warning: unannotated fall-through between
> > >switch labels
> > >>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP'
> > >>   case 1: = ^
> > >>   include/linux/signal.h:190:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 1: = 0;
> > >>   ^
> > >>   include/linux/jhash.h:95:2: note: insert '__attribute__((fallthrough));' to silence
> > >this warning
> > >>   case 6: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:95:2: note: insert 'break;' to avoid fall-through
> > >>   case 6: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:96:2: warning: unannotated fall-through between switch
> > >labels
> > >>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   15include/linux/signal.h:190:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>   case 1: = 0;
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-through
> > >>   case 1: = 0;
> > >>   ^
> > >>   break;
> > >>   include/linux/signal.h:203:2: warninginclude/linux/jhash.h:96:2: note: insert
> > >'__attribute__((fallthrough));' to silence this warning
> > >>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:96:2: note: insert 'break;' to avoid fall-through
> > >>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:97:2: warning: unannotated fall-through between switch
> > >labels
> > >>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   : unannotated fall-through between switch labels
> > >>   case 1: = -1;
> > >>   ^
> > >>   warnings generated.
> > >>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>   case 1: = -1;
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/signal.h:15203:2: note: insert 'break;' to avoid fall-through
> > >>   case 1: = -1;
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:97:2: note: insert '__attribute__((fallthrough));' to silence
> > >this warning
> > >>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:97:2: note: insert 'break;' to avoid fall-through
> > >>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:98:2: warning: unannotated fall-through between switch
> > >labels
> > >>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   include/linux/signal.h:233:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 1: ;
> > >>   ^
> > >>   warnings generated.
> > >>   In file included from kernel/printk/printk.c:61:
> > >>   kernel/printk/internal.h:54:20: warninginclude/linux/jhash.h:98:2: note: insert
> > >'__attribute__((fallthrough));' to silence this warning
> > >>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:98:2: note: no previous prototype for function
> > >'vprintk_func'
> > >>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0; }
> > >>   ^
> > >>   kernel/printk/internal.h: insert 'break;' to avoid fall-through
> > >>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:99:2: warning: unannotated fall-through between switch
> > >labels
> > >>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   :54:16: note: declare 'static' if the function is not intended to be used outside
> > >of this translation unit
> > >>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0; }
> > >>   ^
> > >>   static
> > >>   kernel/printk/printk.cinclude/linux/signal.h:233:2: note: insert
> > >'__attribute__((fallthrough));' to silence this warning
> > >>   case 1: ;
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-through
> > >>   case 1: ;
> > >>   ^
> > >>   break;
> > >>   include/linux/signal.h:245:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 1: ;
> > >>   ^
> > >>>> :165:5: warning: no previous prototype for function
> > >'devkmsg_sysctl_set_loglvl'
> > >>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
> > >>   ^
> > >>   kernel/printk/printk.c:165:1: note: declare 'static' if the function is not
> > >intended to be used outside of this translation unit
> > >>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
> > >>   ^
> > >>   static
> > >>   include/linux/jhash.h:99:2: note: insert '__attribute__((fallthrough));' to silence
> > >this warning
> > >>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:99:2: note: insert 'break;' to avoid fall-through
> > >>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:100:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 1: a +=
> > >>   ^
> > >>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>   case 1: ;
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-through
> > >>   case 1: ;
> > >>   ^
> > >>   break;
> > >>   kernel/printk/printk.cinclude/linux/jhash.h:100:2: note: insert
> > >'__attribute__((fallthrough));' to silence this warning
> > >>   case 1: a +=
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:100:2: note: insert 'break;' to avoid fall-through
> > >>   case 1: a +=
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:102:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/
> > >kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   include/linux/jhash.h:102:2: note: insert 'break;' to avoid fall-through
> > >>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/
> > >kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   :2406:10: warning: 'sprintf' will always overflow; destination buffer has size 0,
> > >but format string expands to at least 33
> > >>   len = sprintf(text,
> > >>   ^
> > >>   include/linux/jhash.h:136:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   include/linux/jhash.h:136:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   __attribute__((fallthrough));
> > >>   include/linux/jhash.h:136:2: note: insert 'break;' to avoid fall-through
> > >>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc
> > >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src
> > >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr
> > >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/
> > >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> > >>   ^
> > >>   break;
> > >>   include/linux/jhash.h:137:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 1: a +=
> > >>   ^
> > >>   In file included from kernel/capability.c:13:
> > >>   In file included from include/linux/audit.h:13:
> > >>   In file included from include/linux/ptrace.h:7:
> > >>   In file included from include/linux/sched/signal.h:6:
> > >>   include/linux/signal.h:147:1: warning: unannotated fall-through between
> > >switch labels
> > >>   _SIG_SET_BINOP(sigorsets, _sig_or)
> > >>   ^
> > >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>   case 2: ^
> > >>   include/linux/signal.h:147:1: warning: unannotated fall-through between
> > >switch labels
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>   case 1: ^
> > >>   include/linux/signal.h:150:1: warning: unannotated fall-through between
> > >switch labels
> > >>   _SIG_SET_BINOP(sigandsets, _sig_and)
> > >>   ^
> > >>   include/linux/signal.h:133:2:In file included from note: expanded from macro
> > >'_SIG_SET_BINOP'
> > >>   case 2: ^
> > >>   include/linux/signal.h:150:1: warning: unannotated fall-through between
> > >switch labels
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>   case 1: ^
> > >>   include/linux/signal.h:153:1: warning: unannotated fall-through between
> > >switch labels
> > >>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
> > >>   ^
> > >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>   case 2: kernel/sysctl_binary.c:15:
> > >>   In file included from include/linux/netdevice.h:37:
> > >>   In file included from include/linux/ethtool.h:18:
> > >>   In file included from include/uapi/linux/ethtool.h:19:
> > >>   In file included from include/linux/if_ether.h:19:
> > >>   include/linux/skbuff.h:3690:2: warning: unannotated fall-through between
> > >switch labels
> > >>   case 24: diffs |= __it_diff(a, b, 64);
> > >>   ^
> > >>--
> > >>           ^
> > >>           __attribute__((fallthrough));
> > >>   include/linux/mm.h:166:2: note: insert 'break;' to avoid fall-through
> > >>           case 56:
> > >>           ^
> > >>           break;
> > >>   In file included from kernel/printk/printk.c:36:
> > >>   In file included from include/linux/syscalls.h:76:
> > >>   include/linux/signal.h:147:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   _SIG_SET_BINOP(sigorsets, _sig_or)
> > >>   ^
> > >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 2:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:147:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 1:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:150:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   _SIG_SET_BINOP(sigandsets, _sig_and)
> > >>   ^
> > >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 2:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:150:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 1:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:153:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
> > >>   ^
> > >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 2:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:153:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
> > >>           case 1:                                                         \
> > >>           ^
> > >>   include/linux/signal.h:177:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   _SIG_SET_OP(signotset, _sig_not)
> > >>   ^
> > >>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP'
> > >>           case 2: set->sig[1] = op(set->sig[1]);                          \
> > >>           ^
> > >>   include/linux/signal.h:177:1: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP'
> > >>           case 1: set->sig[0] = op(set->sig[0]);                          \
> > >>           ^
> > >>   include/linux/signal.h:190:2: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>           case 1: set->sig[0] = 0;
> > >>           ^
> > >>   include/linux/signal.h:190:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>           case 1: set->sig[0] = 0;
> > >>           ^
> > >>           __attribute__((fallthrough));
> > >>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-through
> > >>           case 1: set->sig[0] = 0;
> > >>           ^
> > >>           break;
> > >>   include/linux/signal.h:203:2: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>           case 1: set->sig[0] = -1;
> > >>           ^
> > >>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>           case 1: set->sig[0] = -1;
> > >>           ^
> > >>           __attribute__((fallthrough));
> > >>   include/linux/signal.h:203:2: note: insert 'break;' to avoid fall-through
> > >>           case 1: set->sig[0] = -1;
> > >>           ^
> > >>           break;
> > >>   include/linux/signal.h:233:2: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>           case 1: ;
> > >>           ^
> > >>   include/linux/signal.h:233:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>           case 1: ;
> > >>           ^
> > >>           __attribute__((fallthrough));
> > >>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-through
> > >>           case 1: ;
> > >>           ^
> > >>           break;
> > >>   include/linux/signal.h:245:2: warning: unannotated fall-through between
> > >switch labels [-Wimplicit-fallthrough]
> > >>           case 1: ;
> > >>           ^
> > >>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrough));' to
> > >silence this warning
> > >>           case 1: ;
> > >>           ^
> > >>           __attribute__((fallthrough));
> > >>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-through
> > >>           case 1: ;
> > >>           ^
> > >>           break;
> > >>   In file included from kernel/printk/printk.c:61:
> > >>   kernel/printk/internal.h:54:20: warning: no previous prototype for function
> > >'vprintk_func' [-Wmissing-prototypes]
> > >>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
> > >>                      ^
> > >>   kernel/printk/internal.h:54:16: note: declare 'static' if the function is not
> > >intended to be used outside of this translation unit
> > >>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
> > >>                  ^
> > >>                  static
> > >>>> kernel/printk/printk.c:165:5: warning: no previous prototype for
> > >>>> function 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
> > >>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> > >>       ^
> > >>   kernel/printk/printk.c:165:1: note: declare 'static' if the function is not
> > >intended to be used outside of this translation unit
> > >>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> > >>   ^
> > >>   static
> > >>   kernel/printk/printk.c:2406:10: warning: 'sprintf' will always overflow;
> > >destination buffer has size 0, but format string expands to at least 33 [-Wfortify-
> > >source]
> > >>                           len = sprintf(text,
> > >>                                 ^
> > >>   18 warnings generated.
> > >>
> > >>---
> > >>0-DAY CI Kernel Test Service, Intel Corporation
> > >>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
> > >
> > >
> > >--
> > >Wei Yang
> > >Help you, Help me
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/MN2PR11MB4064B0104312A3D22F1698F3E5670%40MN2PR11MB4064.namprd11.prod.outlook.com.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
