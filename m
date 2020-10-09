Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5058288072
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgJICpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgJICpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:45:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C51C0613D2;
        Thu,  8 Oct 2020 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8azVUMF2a8Wg5CG7wBoZUPHCKs5CLu7GlBQUy9KsC34=; b=O+NEkicnziFy9UmUAGbDgi5F3A
        E2un6mti0oU4bIp6xMxAbu2VP8X8Ex7NRndpKWurMMHYSxIo40rLa3Prv8z0+jPGwTpYju3Y5BMK4
        tNtS7xQduyiPR+ge5f8tMQETm7u64J2WbNaWV56daoOqq6LFVUsS1auh3goFdMm4N2lYLIVSFrD+R
        r2pK4WyhUE6FvulN1JvABWusIqqA8ayFxmp/4HeDSr8hXH+wYvv+CCpbVolkUOujAbyYj5nMO7FSf
        NsADCBRcVt5jKABx/Nt5JWa6EMXqMLPHtcetd2O5ZiDcSrbHCMum88jfMrKEAI8mnt/2LoRNhxWZr
        iEpvFsqA==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQiP9-0001Sy-4N; Fri, 09 Oct 2020 02:45:11 +0000
Subject: Re: [RFC PATCH v1 21/26] docs: reporting-bugs: details on writing and
 sending the report
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <89c5aa12cdb55568b3e33afbe8c5afddf54dddf6.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05897f9c-8039-51f1-27b2-97c65a3913db@infradead.org>
Date:   Thu, 8 Oct 2020 19:45:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <89c5aa12cdb55568b3e33afbe8c5afddf54dddf6.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Outline how to write the report. Give instructions that hopefully will
> make people write better reports that ideally are also quick to evaluate
> for kernel developers.
> 
> At the same time put some more faith into the readers to make them
> provide all relevant data. That's a bit different to the old approach,
> which told people to always send contents of files like /proc/ioports or
> /proc/iomem, which in a lot of cases won't be needed and make reports
> unnecessarily big.
> 
> That's also why this commit removes scripts/ver_linux as well: the
> details it collects are only needed in some situations and make reports
> bigger and harder to compile without good reason. Additionally, some
> distributions do not ship it; a better, more modern script would likely
> resist in tools/, then distros might start shipping it in packages like
> "linux-tools".
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 247 +++++++++++++++----
>  scripts/ver_linux                            |  81 ------
>  2 files changed, 198 insertions(+), 130 deletions(-)
>  delete mode 100755 scripts/ver_linux
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 71c49347c544..b06935cad880 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -845,6 +845,204 @@ freshly to each newer kernel version you try. Afterwards run
>  enabling any new feature, as those are allowed to cause regressions.
>  
>  
> +Write and send the report
> +-------------------------
> +
> +    *Start to compile the report by writing a detailed description about the
> +    issue. Always mentions a few things: the latest kernel version you installed

                     mention

> +    for reproducing, the Linux Distribution used, and your notes how to

                                                              notes {of,on} how to

> +    reproduce the issue. Ideally, make the kernels build configuration (.config)

                                              kernel's

> +    and the output from ``dmesg`` available somewhere on the net and link to it.
> +    Include or upload all other information that might be relevant, like the
> +    output/screenshot of an Oops or the output from ``lspci``. Once you wrote
> +    this main part insert a normal length paragraph on top of it outlining the
> +    issue and the impact quickly. On top of this add one sentence that briefly
> +    describes the problem and gets people to read on. Now give the thing a
> +    descriptive title or subject that yet again is shorter. Then you're ready to
> +    send or file the report like the MAINTAINERS file told you, unless you are
> +    dealing with one of those 'issues of high priority': they need special care
> +    which is explained in 'Special handling for high priority issues' below.*
> +
> +Now that you have prepared everything it's time to write your report. How to do
> +that is partly explained by the two documents linked to in the preface above.
> +
> +This text will only mention a few of the essentials as well as things apecific

                                                                         specific

> +to the Linux kernel. There is one thing that fits both categories: the most
> +crucial parts of your report are the title/subject, the first sentence and the
> +first paragraph. Developers often get quite a lot of mail and have to quickly
> +decide if one is really worth reading. Developer sometimes take just a few
> +seconds to skim a mail before deciding if it's worth a closer look. Thus: the
> +better the top section of your report, the higher are the chances that someone
> +will look into it and help you. And that why you should ignore them for now

                                       that is why

> +and write the detailed report first. ;-)
> +
> +Things each report should mention
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Describe in detail how your issue happens with the fresh vanilla kernel you
> +installed. Try to include the step-by-step instructions you wrote and optimized
> +earlier that descibe how you and ideally others can reproduce the issue; in

                describe

> +those rare cases where that's impossible try to describe what you did to trigger
> +it.
> +
> +Also include all the relevant information others might need to understand the
> +issue and its environment. What's actually needed depends a lot on the issue,
> +but there are some things you should include always:
> +
> + * the output from ``cat /proc/version``, which contains the Linux kernel
> +   version number and the compiler it was built with.
> +
> + * the Linux distribution the machine is running (``hostnamectl | grep
> +   "Operating System"``)
> +
> + * the architecture of the CPU and the operating system (``uname -mi``)
> +
> + * if you are dealing with a regression and performed a bisection, mention the
> +   subject and the commit-id of the culprit.
> +
> +In a lot of cases it's also wise to make two more things available to those
> +that read your report:
> +
> + * the configuration used for building your Linux kernel (the '.config' file)
> +
> + * the kernels messages that you get from ``dmesg``. Make sure it near the top

          kernel's                                      Make sure that it contains
a line lie ' ... ' near the top; otherwise messages


> +   contains a line like 'Linux version 5.8-1 (foobar@example.com) (gcc (GCC)
> +   10.2.1, GNU ld version 2.34) #1 SMP Mon Aug 3 14:54:37 UTC 2020', as
> +   otherwise messages from the first boot phase are already gone from the
> +   buffer. In this case instead consider using ``journalctl -b 0 -k``;
> +   alternatively you can also reboot, reproduce the issue and call ``dmesg``
> +   right afterwards.
> +
> +This data files are big, that's why it's a bad idea to put them directly into

   This data file is big; that's why

> +your report. If you are filing the issue in a bug tracker then attach them to
> +the ticket. If you report the issue by mail do not attach them, as that makes
> +the mail too large; instead do one of these things:
> +
> + * Upload the files somewhere public (your website, a public file paste
> +   service, a ticket created just for this purpose on `bugzilla.kernel.org
> +   <https://bugzilla.kernel.org/>`_, ...) and include a link to them in your
> +   report. Ideally use something where the files stay available for years, as
> +   they could be useful to someone many years from now; this for example can
> +   happen if somebody else runs into the same issue or when a developer works on
> +   some code that was changed to fix your issue.
> +
> + * Put the files aside and mention you will send them later in individual
> +   replies to your own mail. Just remember to actually do that once the report
> +   went out. ;-)
> +
> +Things that might be wise to provide
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Depending on the issue you might need to add more files with background data.
> +Here are a few suggestions what often is good to provide:
> +
> + * If you are dealing with a 'warning', an 'OOPS' or a 'panic' from the kernel,
> +   include it. If you can't copy' n'paste it try to capture a netconsole trace

                  If you can't copy'n'paste it, try

> +   or take a picture of the screen.
> +
> + * If the issue might be related to your computer hardware mention what kind of

                                                     hardware, mention

> +   system you use. If you for example have problems with your graphics card

                                                                          card,

> +   mention its manufacturer and the cards model. If it's a Laptop mention its

                                       card's                 laptop,


> +   name, but try to make sure it's meaningful. 'Dell XPS 13' for example is
> +   not, because it might be the one from 2012; that one might look a bit similar
> +   to the one sold today, but apart from that the two have nothing in common.
> +   Hence, in such cases add the exact model number, which for example are
> +   '9380' or '7390' for XPS 13 models introduced during 2019. Names like
> +   'Lenovo Thinkpad T590' are also somewhat ambiguous: there are variants of
> +   this Laptop with and without a dedicated graphics chip, so try to find the

           laptop

> +   exact models name or specify the main components.

            model's
or          model name

> +
> + * Mention the Software in the environment that's relevant. If you have
> +   problems with loading modules, you want to mention the versions of kmod,
> +   systemd, and udev in use. If one of the DRM drivers misbehaves, you want to
> +   state the versions of libdrm and Mesa; also specify your Wayland compositor
> +   or the X-Server and its driver. If you have a filesystem issue, mention the

             X Server

> +   version of corresponding filesystem utilities (e2fsprogs, btrfs-progs,
> +   xfsprogs, …).

Can we try to use ASCII as much as possible (for text/console readability)?
So just "...".

> +
> + * Gather additional information from the kernel that might be of interest. The
> +   output from ``lspci -nn`` will for example help others to identify what
> +   hardware you use. If you have a problem with hardware you even might want to
> +   make the output from ``sudo lspci -vvv`` available, as that provides
> +   insights how the components were configured. For some issues it might be
> +   good to include the contents of files like ``/proc/cpuinfo``,
> +   ``/proc/ioports``, ``/proc/iomem``, ``/proc/modules``, or
> +   ``/proc/scsi/scsi``. Some subsystem also offer tools to collect relevant
> +   information. One such tool is ``alsa-info.sh`` `which the audio/sound
> +   subsystem developers provide <https://www.alsa-project.org/wiki/AlsaInfo>`_.
> +
> +That will give your some ideas what data might be wise to send, but you have to

                            ideas of what data

> +think yourself what might be helpful for others to know. Don't worry too much
> +about forgetting something: developers will ask for additional details they
> +need; but making everything important available from the start increases the
> +chance someone will take a closer look.
> +
> +The important part: the head of your report
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Now that you have the detailed part of the report prepared let's get back to
> +the most important section: the first few sentences. Thus go to the top, add
> +something like 'The detailed description:' before the part you wrote and insert
> +two newlines at the top. Now write one normal length paragraph that describes
> +the issue roughly. Leave out all boring details and focus on the crucial parts
> +readers need to know to understand what this is all about; if you think this
> +bug affects a lot of users, mention this to get people interested.
> +
> +Once you did that insert two more lines at the top and write a one sentence
> +summary that explains quickly what the report is about. After that you have to
> +get even more abstract and write an even short subject/title for the report.

                                            shorter

> +
> +Now that you have written this part take some time to optimize it, as it is the
> +most important parts of your report: a lot of people will only read this before
> +they decide if reading the rest is time well spend.

                                                spent.

> +
> +Now send or file the report like the `MAINTAINERS file
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
> +told you, unless it's one of those 'issues of high priority' outlined earlier:
> +In that read the next subsection before sending the report.
> +
> +Special handling for high priority issues
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +High priority issues need special handling when sending the report:
> +
> +
> + * *Regression* If the issue is a regression add [REGRESSION] to the mails

                                                                        mail's

> +   subject or the title in the bug-tracker. If you did not perform a bisection
> +   mention at least the latest mainline version you tested that worked fine (say
> +   5.7) and the oldest where the issue occurs (say 5.8). If you did a successful
> +   bisection mention the commit id and subject of the change that causes the
> +   regression. Also make sure to add the author of that change to your report;
> +   if you need to file your bug in a bug-tracker forward the report to him in a
> +   private mail and mention where your filed it.
> +
> + * *Severe bug*: make sure the subject or ticket title as well as the first para

                                                                               paragraph

> +   makes the severeness obvious.
> +
> + * *Security issues*: for these issues your will have to evaluate if a
> +   short-term risk to other users would arise if details were publicly
> +   disclosed. If that's not the case simply proceed with reporting the issue as
> +   described. For issues that bear such a risk you will need to adjust the
> +   reporting process slightly:
> +
> +   * If the MAINTAINERS file instructed you to report the issue by mail, do not
> +     CC any public mailing lists.
> +
> +   * If you were supposed to file the issue in a bug tracker make sure to mark
> +     the ticket as 'private' or 'security issue'. If the bug tracker does not
> +     offer a way to keep reports private, forget about it and send your report
> +     as a private mail to the maintainers instead.
> +
> +   In both cases make sure to inform those that the MAINTAINERS file lists in
> +   the section 'security contact'. Ideally CCing them on the mail with the
> +   report. If you filed it in a bug tracker forward the reports text, but on top

parse error in first 2 sentences above...
                                                           report's

> +   of it put a small note where you mention that you filed it with a link to the
> +   ticket.
> +
> +   See :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` for more
> +   information.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> @@ -867,55 +1065,6 @@ How to report Linux kernel bugs
>  ===============================
>  
>  
> -Gather information
> -------------------
> -
> -The most important information in a bug report is how to reproduce the
> -bug.  This includes system information, and (most importantly)
> -step-by-step instructions for how a user can trigger the bug.
> -
> -If the failure includes an "OOPS:", take a picture of the screen, capture
> -a netconsole trace, or type the message from your screen into the bug
> -report.
> -
> -This is a suggested format for a bug report sent via email or bugzilla.
> -Having a standardized bug report form makes it easier for you not to
> -overlook things, and easier for the developers to find the pieces of
> -information they're really interested in.  If some information is not
> -relevant to your bug, feel free to exclude it.
> -
> -First run the ver_linux script included as scripts/ver_linux, which
> -reports the version of some important subsystems.  Run this script with
> -the command ``awk -f scripts/ver_linux``.
> -
> -Use that information to fill in all fields of the bug report form, and
> -post it to the mailing list with a subject of "PROBLEM: <one line
> -summary from [1.]>" for easy identification by the developers::
> -
> -  [1.] One line summary of the problem:
> -  [2.] Full description of the problem/report:
> -  [3.] Keywords (i.e., modules, networking, kernel):
> -  [4.] Kernel information
> -  [4.1.] Kernel version (from /proc/version):
> -  [4.2.] Kernel .config file:
> -  [5.] Most recent kernel version which did not have the bug:
> -  [6.] Output of Oops.. message (if applicable) with symbolic information
> -       resolved (see Documentation/admin-guide/bug-hunting.rst)
> -  [7.] A small shell script or example program which triggers the
> -       problem (if possible)
> -  [8.] Environment
> -  [8.1.] Software (add the output of the ver_linux script here)
> -  [8.2.] Processor information (from /proc/cpuinfo):
> -  [8.3.] Module information (from /proc/modules):
> -  [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> -  [8.5.] PCI information ('lspci -vvv' as root)
> -  [8.6.] SCSI information (from /proc/scsi/scsi)
> -  [8.7.] Other information that might be relevant to the problem
> -         (please look in /proc and include all information that you
> -         think to be relevant):
> -  [X.] Other notes, patches, fixes, workarounds:
> -
> -
>  Follow up
>  =========
>  


-- 
~Randy

